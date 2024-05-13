import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart' as p;

import 'package:chatapp/src/features/authentication/auth.dart';
import 'package:chatapp/src/features/authentication/domain/chats_manager.dart';

import 'package:chatapp/src/injector_container.dart';
import 'package:chatapp/src/services/local_path_service.dart';
import 'package:chatapp/src/services/permission_service.dart';
import 'package:chatapp/src/shared/widgets/snackbar_global.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

XFile? imageFile;
String? extensionFile, fileBase64;
FilePickerResult? result;
bool _loadingPath = false;
bool isFileACtive = false;
String isLoading = 'Cargando...';
List<PlatformFile>? _paths;

class _ChatScreenState extends State<ChatScreen> {
  bool hasPermission = false;
  final AuthCubit _authCubit = serviceLocator<AuthCubit>();

  var checkPermissions = PermissionService();

  final ListChatsManager _listChatsManager = serviceLocator<ListChatsManager>();
  String myID = '';
  late ScrollController _scrollController;
  late SharedPreferences _pref;

  TextEditingController messageCntrl = TextEditingController();
  checkPermission() async {
    var permission = await checkPermissions.isStoragePermissionGranted();
    if (permission) {
      setState(() {
        hasPermission = true;
      });
    }
  }

  _buildAuthCubitListener() {
    return BlocListener<AuthCubit, AuthState>(
      bloc: _authCubit,
      listener: (context, state) async {
        if (state is AuthLoadingState) {
          // showProgressDialog(
          //   context,
          // );
        } else if (state is AuthErrorState) {
          // Navigator.pop(context);

          showGlobalSnackbar(context,
              message: state.message ?? 'Algo salió mal');
        } else if (state is AuthGetChatMessagesSuccessState) {
          _listChatsManager.chatsToShow = state.chatsToShow;
          setState(() {});
        } else if (state is AuthSendMessageSuccessState) {
          _authCubit.getChatWithIDUser(
              idOtherPerson: _listChatsManager.chatsToShow?[0].toId ?? '');
          setState(() {
            _loadingPath = false;
            fileBase64 = null;
            imageFile = null;
            _paths = [];
            isFileACtive = false;
          });
        } else if (state is AuthGetDataUsersState) {
          // Navigator.pop(context);
          setState(() {
            _loadingPath = false;
          });
        } else {
          setState(() {
            _loadingPath = false;
          });
          // Navigator.pop(context);
        }
      },
      child: const SizedBox(),
    );
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _pref = await SharedPreferences.getInstance();
      myID = _pref.getString('usuario') ?? '';
      isFileACtive = false;

      checkPermission();
      // _scrollController.animateTo(
      //   _scrollController.position.maxScrollExtent,
      //   duration: Duration(milliseconds: 1),
      //   curve: Curves.easeOut,
      // );
      if (_scrollController.hasClients) {
        if (mounted) {
          _scrollController.jumpTo(_scrollController.position.minScrollExtent);
        }
      }
      setState(() {});
    });
    super.initState();
  }

  // _scrollController = new ScrollController();

  // _scrollController.addListener(
  //     () {
  //         double maxScroll = _scrollController.position.maxScrollExtent;
  //         double currentScroll = _scrollController.position.pixels;
  //         double delta = 200.0; // or something else..
  //         if ( maxScroll - currentScroll <= delta) { // whatever you determine here
  //             //.. load more
  //         }
  //     }
  // );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B202D),
        body: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAuthCubitListener(),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            )),
                        SizedBox(
                          width: 15.w,
                        ),
                        // CircleAvatar(
                        //   radius: 25.r,
                        //   backgroundImage:
                        //       Image.asset('assets/images/chat111.png').image,
                        // ),
                        CircleAvatar(
                          radius: 25.r,
                          backgroundImage: Image.network(
                            _listChatsManager.chatsSelected?.imagen ?? '',
                            errorBuilder: (context, error, stackTrace) =>
                                const Placeholder(),
                          ).image,
                          //  Image.asset('assets/images/chat111.png').image,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          _listChatsManager.chatsSelected?.nombre ?? '',
                          style: TextStyle(
                              fontSize: 18.h,
                              fontFamily: ('Quicksand'),
                              color: Colors.white),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.search_rounded,
                          color: Colors.white70,
                          size: 40.h,
                        )
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Expanded(
                        child: FutureBuilder(
                      future: getMessages(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return ListView(
                          controller: _scrollController,
                          reverse: true,
                          children: _listChatsManager.chatsToShow == null
                              ? []
                              : _listChatsManager.chatsToShow!.map((e) {
                                  if (e.userId == myID) {
                                    return _messageItem(
                                        extension: e.extension,
                                        message: e.decodedMessage ?? '',
                                        isMine: true);
                                  } else {
                                    return _messageItem(
                                        extension: e.extension,
                                        message: e.decodedMessage ?? '',
                                        isMine: false);
                                  }
                                }).toList(),
                        );
                      },
                    )),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Container(
                        height: 45.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            color: const Color(0xff3D4354)),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4.h),
                              child: GestureDetector(
                                onTap: () {
                                  showSelectOriginImage();
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 40.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white30,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Icon(Icons.camera_alt_outlined),
                                ),
                              ),
                            ),
                            SizedBox(width: 15.w),

                            SizedBox(
                              width: 250.w,
                              child: TextFormField(
                                controller: messageCntrl,
                                textAlign: TextAlign.start,
                                style: const TextStyle(color: Colors.white),
                                readOnly: isFileACtive,
                                decoration: const InputDecoration(
                                  //  Text(
                                  //   'Mensaje',
                                  //   style: TextStyle(color: Colors.white),
                                  // ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  counter: SizedBox(),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 9),
                                ),
                                onChanged: (x) {
                                  setState(() {});
                                },
                              ),
                            ),
                            // const Spacer(),
                            Transform.rotate(
                              angle: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  await _openFileExplorer();
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: const Icon(
                                    Icons.attach_file,
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: InkWell(
                                onTap: () async {
                                  _loadingPath = true;

                                  if (messageCntrl.text.isNotEmpty) {
                                    _authCubit.sendMessage(
                                        extensionFile: extensionFile,
                                        archivo: fileBase64,
                                        otherPersonId: _listChatsManager
                                                .chatsUser?[0].otherPersonId ??
                                            '1',
                                        message: messageCntrl.text);
                                    messageCntrl.clear();

                                    setState(() {});
                                    // _listChatsManager.chatsUser.[]
                                  } else {
                                    _loadingPath = true;

                                    if (imageFile != null) {
                                      fileBase64 =
                                          await converBase64xFile(imageFile);

                                      extensionFile = p.extension(
                                          imageFile!.path); // '.dart'
                                    } else if (_paths?.isNotEmpty == true) {
                                      fileBase64 =
                                          await converBase64PlatformFile(
                                              _paths);
                                      extensionFile = _paths![0].extension;
                                    }
                                    if ((imageFile != null) ||
                                        (_paths?.isNotEmpty == true)) {
                                      _authCubit.sendMessage(
                                          extensionFile: extensionFile,
                                          archivo: fileBase64,
                                          otherPersonId: _listChatsManager
                                                  .chatsUser?[0]
                                                  .otherPersonId ??
                                              '1',
                                          message: messageCntrl.text);
                                      messageCntrl.clear();
                                      setState(() {});
                                    }
                                  }
                                },
                                child: Icon(
                                  Icons.send,
                                  color: _loadingPath
                                      ? Colors.black
                                      : Colors.white54,
                                ),
                              ),
                            ),
                          ],

                          ///thankyou alll of youuuuuu se you next tutorial
                        ),
                      ),
                    )
                  ],
                ),
                _buildButtonToJumpDown(),
                _buildShowImage(),
                _buildShowFile(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getMessages() async {
    if (_loadingPath == false && isFileACtive == false) {
      _authCubit.getChatWithIDUserPeriodic(
          idOtherPerson: _listChatsManager.chatsSelected?.otherPersonId ?? '');
    }
  }

  Widget _buildButtonToJumpDown() {
    return Positioned(
        bottom: 70.h,
        right: 10.w,
        child: GestureDetector(
          onTap: () {
            if (mounted) {
              _scrollController
                  .jumpTo(_scrollController.position.minScrollExtent);
            }
          },
          child: const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.arrow_downward_sharp,
              color: Colors.white,
            ),
          ),
        ));
  }

  Widget _buildShowImage() {
    return Positioned(
        bottom: 50.h,
        child: imageFile == null
            ? const SizedBox()
            : Container(
                height: 300.h,
                decoration: BoxDecoration(
                    color: const Color(0xff373E4E),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    )),
                child: Stack(children: [
                  Center(
                    child: SizedBox(
                        width: 300.w,
                        height: 280.h,
                        child: Image.file(File(imageFile!.path))),
                  ),
                  Positioned(
                      top: 10,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          imageFile = null;
                          isFileACtive = false;
                          setState(() {});
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ])));
  }

  Widget _buildShowFile() {
    return Positioned(
        bottom: 50.h,
        child: _paths == null || _paths!.isEmpty
            ? const SizedBox()
            : Container(
                height: 300.h,
                width: 300.w,
                decoration: BoxDecoration(
                    color: const Color(0xff373E4E),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    )),
                child: Stack(children: [
                  Center(
                    child: Container(
                        width: 200.w,
                        height: 70.h,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 5.h, horizontal: 10.w),
                        child: Center(child: Text(_paths?[0].name ?? ''))),
                    //  Image.file(File(_paths![0].path ?? ''))),
                  ),
                  Positioned(
                      top: 10,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          _paths = null;
                          isFileACtive = false;
                          setState(() {});
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ])));
  }

  showSelectOriginImage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.w))),
              insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
              contentPadding: EdgeInsets.zero,
              content: Container(
                  width: 300.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Elige una opción'),
                          SizedBox(height: 30.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  imageFile = await picker.pickImage(
                                      source: ImageSource.camera);
                                  if (imageFile != null) {
                                    isFileACtive = true;

                                    setState(() {});
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Icon(Icons.camera_alt, size: 30),
                              ),
                              SizedBox(width: 20.w),
                              Container(
                                height: 60.h,
                                width: 1,
                                color: Colors.black,
                              ),
                              SizedBox(width: 20.w),
                              InkWell(
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  imageFile = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (imageFile != null) {
                                    isFileACtive = true;

                                    setState(() {});

                                    Navigator.pop(context);
                                  }
                                },
                                child: const Icon(Icons.photo, size: 30),
                              ),
                            ],
                          ),
                        ],
                      ))));
        });
  }

  Widget _messageItem(
      {String? extension, required String message, required bool isMine}) {
    var imageExtensions = [
      'heic',
      'jpg',
      'jpeg',
      'png',
    ];
    if (extension != null && imageExtensions.contains(extension)) {
      return Padding(
        padding: isMine
            ? EdgeInsets.only(left: 70.w, bottom: 10.h)
            : EdgeInsets.only(right: 70.h, bottom: 10.h),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:
                  isMine ? const Color(0xff7A8194) : const Color(0xff373E4E)),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Image.network(
            message,
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    if (extension != null) {
      return MessageBubble(
        message: message,
        isMine: isMine,
      );
    }

    return Padding(
      padding: isMine
          ? EdgeInsets.only(left: 70.w, bottom: 10.h)
          : EdgeInsets.only(right: 70.h, bottom: 10.h),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isMine ? const Color(0xff7A8194) : const Color(0xff373E4E)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['heic', 'jpg', 'pdf', 'doc', 'docx', 'png', 'zip'],
      ))
          ?.files;
      setState(() {});
      if (_paths == null) return;
      if (_paths!.isNotEmpty) {
        isLoading = _paths![0].name;
        isFileACtive = true;
        _loadingPath = false;
        setState(() {});
      }
    } on PlatformException catch (e) {
      log("Unsupported operation $e");
    } catch (ex) {
      log("ex sUnsupported operation $ex");

      log('$ex');
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      // _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
    });
  }

  converBase64xFile(XFile? imageFile) {
    List<int> imageBytes = File(imageFile!.path).readAsBytesSync();

    return base64Encode(imageBytes);
  }

  converBase64PlatformFile(List<PlatformFile>? paths) {
    List<int> imageBytes = File(paths![0].path!).readAsBytesSync();

    return base64Encode(imageBytes);
  }

  String getLastMessage() {
    if (_paths != null) {
      return _paths![0].name;
    } else if (imageFile != null) {
      return imageFile!.name;
    }
    return messageCntrl.text;
  }
}

class MessageBubble extends StatefulWidget {
  final String message;
  final bool isMine;
  const MessageBubble({
    super.key,
    required this.message,
    required this.isMine,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool dowloading = false;
  bool fileExist = false;
  double progress = 0;
  String fileName = '';
  String typeDoc = '', nameFile = '';
  late String filePath;

  var getPathFile = LocalPathService();
  late CancelToken cancelToken;
  checkFileExist() async {
    cancelToken = CancelToken();

    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      fileExist = fileExistCheck;
    });
  }

  openFile() {
    OpenFile.open(filePath);
  }

  startDownload() async {
    log('=== START DOWn');

    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    try {
      await Dio().download(widget.message, filePath,
          onReceiveProgress: (count, total) {
        setState(() {
          progress = count / total;
          log('Download in progress $progress');
        });
      }, cancelToken: cancelToken);
      setState(() {
        dowloading = false;
        fileExist = true;
        log('Download is cancel $progress');
      });
    } catch (e) {
      setState(() {
        log('something happend! $progress');

        dowloading = false;
      });
    }
  }

  cancelDownload() {
    cancelToken.cancel();
    setState(() {
      dowloading = false;
    });
  }

  @override
  void initState() {
    setState(() {
      fileName = p.basename(widget.message);
      nameFile = widget.message
          .replaceAll('https://ecogreemperu.com/wsp/archivos/', '');
      typeDoc = nameFile.substring(nameFile.indexOf('.'));
    });
    checkFileExist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        // padding: EdgeInsets.only(left: 0.w, bottom: 10.h),
        alignment: widget.isMine ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 200,
          height: 50,
          margin: const EdgeInsets.only(bottom: 10),
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.isMine
                  ? const Color(0xff7A8194)
                  : const Color(0xff373E4E)),
          child: Container(
            width: 80,
            height: 40,
            padding: const EdgeInsets.only(
              left: 5,
              right: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.black.withOpacity(.4),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nameFile,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Archivo $typeDoc',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                GestureDetector(
                    onTap: () {
                      dowloading
                          ? cancelDownload()
                          : fileExist
                              ? openFile()
                              : startDownload();
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        !fileExist
                            ? Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                  value: progress,
                                  backgroundColor: Colors.grey,
                                ),
                              )
                            : const SizedBox(),
                        Center(
                          child: Icon(
                            dowloading
                                ? Icons.close
                                : fileExist
                                    ? Icons.folder_open_rounded
                                    : Icons.save,
                            color: Colors.white,
                            size: 13,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
