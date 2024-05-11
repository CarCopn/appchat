import 'package:chatapp/src/features/authentication/auth.dart';
import 'package:chatapp/src/features/authentication/domain/chats_manager.dart';
import 'package:chatapp/src/features/authentication/domain/entities/chats_list_resp.dart';
import 'package:chatapp/src/features/chat/presentation/screens/chat_screen.dart';
import 'package:chatapp/src/injector_container.dart';
import 'package:chatapp/src/shared/widgets/progress_indicator.dart';
import 'package:chatapp/src/shared/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ListChatsManager _listChatsManager = serviceLocator<ListChatsManager>();

  final AuthCubit _authCubit = serviceLocator<AuthCubit>();
  final TextEditingController _nameCntrl = TextEditingController();
  final TextEditingController _claveCntrl = TextEditingController();
  final TextEditingController _claveExtraCntrl = TextEditingController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ListChatsManager listChatsManager = serviceLocator<ListChatsManager>();
  DateFormat format = DateFormat('yyyy-MM-dd – kk:mm');
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialogConfirmCode(context);
    });
  }

  void _onRefresh() async {
    await _authCubit.listChats();

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  _buildAuthCubitListener() {
    return BlocListener<AuthCubit, AuthState>(
      bloc: _authCubit,
      listener: (context, state) async {
        if (state is AuthLoadingState) {
          // showProgressDialog(
          //   context,
          // );
        } else if (state is AuthLoadingGetMessagesState) {
          showProgressDialog(
            context,
          );
        } else if (state is AuthGetChatMessagesSuccessState) {
          Navigator.pop(context);
          listChatsManager.chatsToShow = state.chatsToShow;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChatScreen()));
          setState(() {});
        } else if (state is AuthErrorState) {
          showGlobalSnackbar(context,
              message: state.message ?? 'Algo salió mal');
        } else if (state is AuthGetListChatSuccessState) {
          listChatsManager.chatsUser = state.chatsUserList;

          setState(() {});
        } else {
          Navigator.pop(context);
        }
      },
      child: const SizedBox(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1B202D),
      body: SmartRefresher(
        enablePullDown: true,
        header: const WaterDropHeader(
          complete: Icon(
            Icons.done,
            color: Colors.grey,
          ),
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAuthCubitListener(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    Text(
                      'Mensajes',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: ('Quicksand'),
                          fontSize: 30.h,
                          color: Colors.white),
                    ),
                    Expanded(child: Container()),
                    IconButton(
                        onPressed: () {
                          showDialogEdit(context);
                        },
                        icon: Icon(
                          Icons.edit_note_rounded,
                          color: Colors.white,
                          size: 35.h,
                        )),
                    IconButton(
                        onPressed: () {
                          showDialogSearchUsuario(context);
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 35.h,
                        )),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const Text(
                  'Recientes',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                  height: 130.h,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: getListOnlineContacts())),
              Expanded(child: Container()),
              Container(
                height: 640.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xff292F3F),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: ListView(
                    children: _listChatsManager.chatsUser!
                        .map((e) => _chatItem(chatUser: e))
                        .toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDialogEdit(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.w))),
                insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
                contentPadding: EdgeInsets.zero,
                content: Container(
                    width: 428.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Padding(
                      padding: const EdgeInsets.all(60.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Actualizar Usuario',
                              style: TextStyle(
                                fontSize: 25.h,
                                fontFamily: 'Arena',
                                fontWeight: FontWeight.w700,
                              )),
                          SizedBox(height: 20.h),
                          Row(children: [
                            Container(
                              width: 120.w,
                              height: 50.h,
                              alignment: Alignment.centerLeft,
                              child: Text('Nombre',
                                  style: TextStyle(
                                    fontSize: 17.h,
                                    fontFamily: 'Arena',
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                            SizedBox(
                              width: 120.w,
                              height: 45.h,
                              child: TextFormField(
                                controller: _nameCntrl,
                                textAlign: TextAlign.start,
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
                                  ),
                                  counter: SizedBox(),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0),
                                ),
                              ),
                            ),
                          ]),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              SizedBox(
                                width: 120.w,
                                height: 40.h,
                                child: Text('Clave',
                                    style: TextStyle(
                                        fontSize: 17.h,
                                        fontFamily: 'Arena',
                                        fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                width: 120.w,
                                height: 45.h,
                                child: TextFormField(
                                  controller: _claveCntrl,
                                  textAlign: TextAlign.start,
                                  maxLength: 6,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                    counter: SizedBox(),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              SizedBox(
                                width: 120.w,
                                height: 40.h,
                                child: Text('Clave',
                                    style: TextStyle(
                                        fontSize: 17.h,
                                        fontFamily: 'Arena',
                                        fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                width: 120.w,
                                height: 45.h,
                                child: TextFormField(
                                  controller: _claveCntrl,
                                  textAlign: TextAlign.start,
                                  maxLength: 6,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                    counter: SizedBox(),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 16),
                              child: SizedBox(
                                height: 52.h,
                                width: 200.w,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  color: Colors.black,
                                  onPressed: () async {},
                                  child: Text(
                                    'Actualizar',
                                    style: TextStyle(
                                        fontSize: 18.h,
                                        fontFamily: 'Arena',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            },
          );
        });
  }

  showDialogConfirmCode(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.w))),
                insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
                contentPadding: EdgeInsets.zero,
                content: Container(
                    width: 400.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 50),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Confirmar código de acceso',
                              style: TextStyle(
                                fontSize: 25.h,
                                fontFamily: 'Arena',
                                fontWeight: FontWeight.w700,
                              )),
                          SizedBox(height: 20.h),
                          Container(
                            width: 300.w,
                            height: 50.h,
                            alignment: Alignment.centerLeft,
                            child: Text('Ingrese código de acceso:',
                                style: TextStyle(
                                  fontSize: 17.h,
                                  fontFamily: 'Arena',
                                )),
                          ),
                          SizedBox(
                            width: 300.w,
                            height: 45.h,
                            child: TextFormField(
                              controller: _nameCntrl,
                              textAlign: TextAlign.start,
                              maxLength: 6,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                counter: SizedBox(),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 16),
                              child: SizedBox(
                                height: 52.h,
                                width: 200.w,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  color: Colors.black,
                                  onPressed: () async {},
                                  child: Text(
                                    'Validar',
                                    style: TextStyle(
                                        fontSize: 18.h,
                                        fontFamily: 'Arena',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            },
          );
        });
  }

  showDialogSearchUsuario(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.w))),
                insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
                contentPadding: EdgeInsets.zero,
                content: Container(
                    width: 400.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 50),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Buscar Usuario',
                              style: TextStyle(
                                fontSize: 25.h,
                                fontFamily: 'Arena',
                                fontWeight: FontWeight.w700,
                              )),
                          SizedBox(height: 20.h),
                          Container(
                            width: 300.w,
                            height: 50.h,
                            alignment: Alignment.centerLeft,
                            child: Text('Ingrese usuario:',
                                style: TextStyle(
                                  fontSize: 17.h,
                                  fontFamily: 'Arena',
                                )),
                          ),
                          SizedBox(
                            width: 300.w,
                            height: 45.h,
                            child: TextFormField(
                              controller: _nameCntrl,
                              textAlign: TextAlign.start,
                              maxLength: 6,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                counter: SizedBox(),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 16),
                              child: SizedBox(
                                height: 52.h,
                                width: 200.w,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  color: Colors.black,
                                  onPressed: () async {},
                                  child: Text(
                                    'Buscar',
                                    style: TextStyle(
                                        fontSize: 18.h,
                                        fontFamily: 'Arena',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            },
          );
        });
  }

  List<Widget> getListOnlineContacts() {
    return [
      SizedBox(
        width: 22.w,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 33.r,
            backgroundImage: Image.asset('assets/images/image1.png').image,
          ),
          SizedBox(height: 8.h),
          Text(
            'Barry',
            style: TextStyle(color: Colors.white, fontSize: 16.h),
          )
        ],
      ),
      SizedBox(
        width: 22.w,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 33.r,
            backgroundImage: Image.asset('assets/images/image22.png').image,
          ),
          SizedBox(height: 8.h),
          Text(
            'Perez',
            style: TextStyle(color: Colors.white, fontSize: 16.h),
          )
        ],
      ),
      SizedBox(
        width: 22.w,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 33.r,
            backgroundImage: Image.asset('assets/images/image33.png').image,
          ),
          SizedBox(height: 8.h),
          Text(
            'Alvin',
            style: TextStyle(color: Colors.white, fontSize: 16.h),
          )
        ],
      ),
      SizedBox(
        width: 22.w,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 33.r,
            backgroundImage: Image.asset('assets/images/image44.png').image,
          ),
          SizedBox(height: 8.h),
          Text(
            'Dan',
            style: TextStyle(color: Colors.white, fontSize: 16.h),
          )
        ],
      ),
      SizedBox(
        width: 22.w,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 33.r,
            backgroundImage: Image.asset('assets/images/image55.png').image,
          ),
          SizedBox(height: 8.h),
          Text(
            'Fresh',
            style: TextStyle(color: Colors.white, fontSize: 16.h),
          )
        ],
      ),
      SizedBox(
        width: 22.w,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 33.r,
            backgroundImage: Image.asset('assets/images/image1.png').image,
          ),
          SizedBox(height: 8.h),
          Text(
            'Barry',
            style: TextStyle(color: Colors.white, fontSize: 16.h),
          )
        ],
      ),
      SizedBox(
        width: 22.w,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 33.r,
            backgroundImage: Image.asset('assets/images/image22.png').image,
          ),
          SizedBox(height: 8.h),
          Text(
            'Perez',
            style: TextStyle(color: Colors.white, fontSize: 16.h),
          )
        ],
      ),
      SizedBox(
        width: 22.w,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 33.r,
            backgroundImage: Image.asset('assets/images/image33.png').image,
          ),
          SizedBox(height: 8.h),
          Text(
            'Alvin',
            style: TextStyle(color: Colors.white, fontSize: 16.h),
          )
        ],
      ),
      SizedBox(
        width: 22.w,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 33.r,
            backgroundImage: Image.asset('assets/images/image44.png').image,
          ),
          SizedBox(height: 8.h),
          Text(
            'Dan',
            style: TextStyle(color: Colors.white, fontSize: 16.h),
          )
        ],
      ),
      SizedBox(
        width: 22.w,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 33.r,
            backgroundImage: Image.asset('assets/images/image55.png').image,
          ),
          SizedBox(height: 8.h),
          Text(
            'Fresh',
            style: TextStyle(color: Colors.white, fontSize: 16.h),
          )
        ],
      ),
      SizedBox(
        width: 22.w,
      ),
    ];
  }

  Widget _chatItem({required ChatsUserResp chatUser}) {
    return GestureDetector(
      onTap: () {
        _authCubit.getChatWithIDUser(
            idOtherPerson: chatUser.otherPersonId ?? '0');
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 26.0, top: 35, right: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundImage: Image.asset('assets/images/chat111.png').image,
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 340.h,
                  child: Row(
                    children: [
                      Text(
                        chatUser.nombre ?? '',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: ('Quicksand'),
                            fontSize: 16.h),
                      ),
                      Expanded(child: Container()),
                      Text(
                        format.format(chatUser.createdAt ?? DateTime.now()),
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  chatUser.message ?? '',
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
