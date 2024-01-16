import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../chat/presentation/screens/ChatScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChatScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 26.0, top: 35, right: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30.r,
                              backgroundImage:
                                  Image.asset('assets/images/chat111.png')
                                      .image,
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
                                      'Danny Hopkins',
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
                                const Text(
                                  'dannylove@gmail.com',
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 35, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage:
                                Image.asset('assets/images/chat222.png').image,
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
                                    'Bobby LangFod',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 16.h),
                                  ),
                                  SizedBox(width: 150.w),
                                  const Text(
                                    'Tue',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              const Text(
                                'Will do,suer,thank you',
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 35, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage:
                                Image.asset('assets/images/chat333.png').image,
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
                                    'William Wiles',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 16.h),
                                  ),
                                  SizedBox(width: 170.w),
                                  const Text(
                                    'Sun',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              const Text(
                                'Uploded File',
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 35, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage:
                                Image.asset('assets/images/chat555.png').image,
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
                                    'James Edlen',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 16.h),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                  ),
                                  const Text(
                                    '23 Mar',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              const Text(
                                "Were is another tutorial",
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 35, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage:
                                Image.asset('assets/images/chat666.png').image,
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
                                    'James Edlen',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 16.h),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                  ),
                                  const Text(
                                    '23 Mar',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              const Text(
                                "Were is another tutorial",
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 35, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage:
                                Image.asset('assets/images/chat777.png').image,
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
                                    'James Edlen',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 16.h),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                  ),
                                  const Text(
                                    '23 Mar',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              const Text(
                                "Were is another tutorial",
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 35, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage:
                                Image.asset('assets/images/chat777.png').image,
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
                                    'James Edlen',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 16.h),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                  ),
                                  const Text(
                                    '23 Mar',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              const Text(
                                "Were is another tutorial",
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 35, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage:
                                Image.asset('assets/images/chat777.png').image,
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
                                    'James Edlen',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 16.h),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                  ),
                                  const Text(
                                    '23 Mar',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              const Text(
                                "Were is another tutorial",
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 35, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage:
                                Image.asset('assets/images/chat777.png').image,
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
                                    'James Edlen',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: ('Quicksand'),
                                        fontSize: 16.h),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                  ),
                                  const Text(
                                    '23 Mar',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              const Text(
                                "Were is another tutorial",
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
}
