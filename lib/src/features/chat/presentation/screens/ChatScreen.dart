// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

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
                      'Danny Hopkins',
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
                const Center(
                  child: Text(
                    '1 FEB 12:00',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff373E4E)),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'I commented on Figma, I want to add\n sjdiw weosjwy cys sow woois ijwdwd wysxta\njsd',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xff7A8194)),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'I commented on Figma, I want to add\n sjdiw weosjwy',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff373E4E)),
                  child: Padding(
                    padding: EdgeInsets.all(10.h),
                    child: const Text(
                      'Next Month',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                const Center(
                  child: Text(
                    '08:12',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 70.w),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xff7A8194)),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'I commented on Figma, I want to add\n sjdiw weosjwy',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 350.w),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xff7A8194)),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
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
}
