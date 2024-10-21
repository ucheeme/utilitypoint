import 'package:camera/camera.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:utilitypoint/utils/image_paths.dart';
import 'package:utilitypoint/utils/text_style.dart';
import 'package:utilitypoint/view/fundWallet/fund_wallet.dart';
import 'package:utilitypoint/view/home/home_screen.dart';
import 'package:utilitypoint/view/transactionHistory/transaction.dart';

import '../utils/app_color_constant.dart';
import '../utils/customClipPath.dart';
import '../utils/myCustomCamera/myCameraScreen.dart';
import 'home/moreOptions.dart';
import 'menuOption/profile.dart';

class MyBottomNav extends StatefulWidget {
  int? position;
  MyBottomNav({super.key,this.position});
  @override
  _MyBottomNavState createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
   // Container(color: const Color(0xFFF5F8FE),),
    TransactionScreen(isBottomNav: true,),
    Container(color: Colors.greenAccent,), // Screen displayed when the Floating Action Button is tapped
    Container(color: Colors.purpleAccent,),
    ProfileScreen(isBottomNav: true,)
  ];
  late List<CameraDescription> cameras;
  @override
  void initState() {
    // Get the list of available cameras
    if(widget.position!=null){
      _currentIndex=widget.position!;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      extendBody: true,
      floatingActionButton: GestureDetector(
        onTap: () async {
          Get.to(Moreoptions(), curve: Curves.easeIn);
        },
        child: customerRoundItemBtn(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        height: 83.h,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 12.r,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            itemWidget(onTap: () {
              setState(() {
                _currentIndex = 0; // Navigate to Screen 1
              });},
                image: "active_home",
                title: "Home", active: _currentIndex == 0
            ),

            itemWidget(onTap: () {
              setState(() {
                _currentIndex = 1; // Navigate to Screen 2
              });},
                image:"inactive_transaction",
                title: "Transactions",
                active: _currentIndex == 1
            ),
            SizedBox(width: 30.w), // Space for the Floating Action Button
            itemWidget(onTap: () {
              setState(() {
                _currentIndex = 3; // Navigate to Screen 4
              });},
                image: "inactive_wallet",
                title: "Fund Wallet",
                active: _currentIndex == 3
            ),
            itemWidget(onTap: () {
              setState(() {
                _currentIndex = 4; // Navigate to Screen 5
              });},
                image: "inactive_profile",
                title: "Profile",
                active: _currentIndex == 4
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   padding: const EdgeInsets.symmetric(horizontal: 10),
      //   height: 60,
      //   color: Colors.cyan.shade400,
      //   shape: const CircularNotchedRectangle(),
      //   notchMargin: 5,
      //   child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       IconButton(
      //         icon: const Icon(
      //           Icons.menu,
      //           color: Colors.black,
      //         ),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: const Icon(
      //           Icons.search,
      //           color: Colors.black,
      //         ),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: const Icon(
      //           Icons.print,
      //           color: Colors.black,
      //         ),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: const Icon(
      //           Icons.people,
      //           color: Colors.black,
      //         ),
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Container customerRoundItemBtn() {
    return Container(
      width: 76.h,height: 76.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(0xFF134DB0),
            Color(0xFF08204A),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(color: Color(0xFF08204A).withOpacity(0.30),
              offset: Offset(0, 15),
              blurRadius: 30, spreadRadius: 1)],
      ),
      child: Center(child:
      Image.asset("assets/float_icon.png",
        width: 24.w,height: 24.h,fit: BoxFit.contain,)),
    );
  }

  GestureDetector itemWidget({required Function() onTap, required String title, required String image, required bool active}) {
    return GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 47.4.h,
          width: 78.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/image/icons/$image.svg",
                color: active ?
                const Color(0xFF134DB0):const Color(0xFF89B5FF),
                width: 20.h,height: 20.h,fit: BoxFit.contain,),
              SizedBox(height: 8.h,),
              Text(title,style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color:
                  active ?
                  const Color(0xFF134DB0):const Color(0xFF89B5FF)
              ),)
            ],

          ),
        ));
  }
}
class CurvedBottomNave extends StatefulWidget {
  const CurvedBottomNave({super.key});

  @override
  State<CurvedBottomNave> createState() => _CurvedBottomNaveState();
}

class _CurvedBottomNaveState extends State<CurvedBottomNave> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size= MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            // Icon(Icons.list, size: 30),
            // Icon(Icons.compare_arrows, size: 30),
            // Icon(Icons.call_split, size: 30),
            // Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          height: 83.h,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) {
            if(index==2){
              return true;
            }else{
              return true;
            }
          },
        ),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child:
              Container(
                height: 83.h,
                width: size.width,
                //color: AppColor.black100,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(size.width, 83.h),
                      // painter: BNBCustomPainter(),
                      painter: CustomShapeClipper(),
                    )
                  ],
                ),
              ),

            )
          ],
        ),
    );
  }
}

