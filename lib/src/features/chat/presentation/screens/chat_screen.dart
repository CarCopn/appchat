import 'dart:developer';
import 'dart:io';

import 'package:chatapp/src/features/authentication/domain/chats_manager.dart';
import 'package:chatapp/src/features/chat/infraestructure/message_service.dart';
import 'package:chatapp/src/injector_container.dart';
import 'package:chatapp/src/services/local_path_service.dart';
import 'package:chatapp/src/services/permission_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as Path;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool hasPermission = false;
  var checkPermissions = PermissionService();

  final ListChatsManager _listChatsManager = serviceLocator<ListChatsManager>();
  String myID = '';
  late ScrollController _scrollController;
  late SharedPreferences _pref;

  checkPermission() async {
    var permission = await checkPermissions.isStoragePermissionGranted();
    if (permission) {
      setState(() {
        hasPermission = true;
      });
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _pref = await SharedPreferences.getInstance();
      myID = _pref.getString('usuario') ?? '';
      checkPermission();
      // _scrollController.animateTo(
      //   _scrollController.position.maxScrollExtent,
      //   duration: Duration(milliseconds: 1),
      //   curve: Curves.easeOut,
      // );
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundImage:
                          Image.asset('assets/images/chat111.png').image,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      _listChatsManager.chatsUser?[0].nombre ?? '',
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
                    child: ListView(
                  controller: _scrollController,
                  children: _listChatsManager.chatsToShow == null
                      ? []
                      : _listChatsManager.chatsToShow!.map((e) {
                          if (e.userId == myID) {
                            return _messageMine(
                                message: e.decodedMessage ?? '');
                          } else {
                            return _messageOtherPerson(
                                message: e.decodedMessage ?? '');
                          }
                        }).toList(),
                )),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
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
                          child: Container(
                            height: 40.h,
                            width: 40.h,
                            decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Icon(Icons.camera_alt_outlined),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        const Text(
                          'Message',
                          style: TextStyle(color: Colors.white54),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: const Icon(
                            Icons.send,
                            color: Colors.white54,
                          ),
                        ),
                      ],

                      ///thankyou alll of youuuuuu se you next tutorial
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _messageMine({required String message}) {
    return Padding(
      padding: EdgeInsets.only(right: 70.h, bottom: 10.h),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xff373E4E)),
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

  Widget _messageOtherPerson({required String message}) {
    return FutureBuilder(
      future: MessageService().isValidImageUrl(message),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return Padding(
            padding: EdgeInsets.only(left: 70.w, bottom: 10.h),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff7A8194)),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Image.network(
                message,
                fit: BoxFit.contain,
              ),
            ),
          );
        }
        if (message.contains('https:')) {
          return MessageBubble(message: message);
        }
        return Padding(
          padding: EdgeInsets.only(left: 70.w, bottom: 10.h),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xff7A8194)),
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
      },
    );
  }
}

class MessageBubble extends StatefulWidget {
  final String message;
  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool dowloading = false;
  bool fileExist = false;
  double progress = 0;
  String fileName = '';
  late String filePath;

  var getPathFile = LocalPathService();
  late CancelToken cancelToken;

  checkFileExist() async {
    cancelToken = CancelToken();

    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      log('fileExist $fileExist');
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
      fileName = Path.basename(widget.message);
    });
    checkFileExist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 70.w, bottom: 10.h),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xff7A8194)),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    widget.message.replaceAll(
                        'https://ecogreemperu.com/wsp/archivos/', ''),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20.w),
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
                              ? CircularProgressIndicator(
                                  color: Colors.blue,
                                  value: progress,
                                  backgroundColor: Colors.grey,
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
                              size: 16,
                            ),
                          ),
                        ],
                      )),
                ],
              )),
        ));
  }
}
