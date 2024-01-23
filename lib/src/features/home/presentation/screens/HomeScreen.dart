import 'package:chatapp/src/features/authentication/domain/chats_manager.dart';
import 'package:chatapp/src/features/authentication/domain/entities/chats_list_resp.dart';
import 'package:chatapp/src/injector_container.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ListChatsManager _listChatsManager = serviceLocator<ListChatsManager>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B202D),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Messages',
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
        // Navigator.push(context,
        // MaterialPageRoute(builder: (context) => const ChatScreen()));
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
                Row(
                  children: [
                    Text(
                      chatUser.nombre ?? '',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: ('Quicksand'),
                          fontSize: 16.h),
                    ),
                    SizedBox(
                      width: 140.w,
                    ),
                    const Text(
                      '08:43',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
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
