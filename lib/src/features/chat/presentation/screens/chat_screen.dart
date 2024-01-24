import 'package:chatapp/src/features/authentication/domain/chats_manager.dart';
import 'package:chatapp/src/injector_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ListChatsManager _listChatsManager = serviceLocator<ListChatsManager>();
  String myID = '';
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      myID = _pref.getString('usuario') ?? '';
      setState(() {});
    });
    super.initState();
  }

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
            )),
      ),
    );
  }
}
