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

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ListChatsManager listChatsManager = serviceLocator<ListChatsManager>();
  DateFormat format = DateFormat('yyyy-MM-dd – kk:mm');

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mensajes',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: ('Quicksand'),
                          fontSize: 30.h,
                          color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 35.h,
                        ))
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
