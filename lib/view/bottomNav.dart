import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:utilitypoint/utils/image_paths.dart';
import 'package:utilitypoint/utils/text_style.dart';
import 'package:utilitypoint/view/fundWallet/fund_wallet.dart';
import 'package:utilitypoint/view/home/home_screen.dart';
import 'package:utilitypoint/view/profile/profile.dart';
import 'package:utilitypoint/view/transactionHistory/transaction.dart';

import '../utils/app_color_constant.dart';
import '../utils/customClipPath.dart';

class MyBottomNav extends StatefulWidget {
  @override
  _MyBottomNavState createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int _selectedIndex = 0;
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  List<Widget> bottomNavScreens=[
    HomeScreen(),
    TransactionScreen(),
    FundWalletScreen(),
    ProfileScreen()
  ];

  // @override
  // Widget build(BuildContext context) {
  //   final size= MediaQuery.of(context).size;
    @override
    Widget build(BuildContext context) {
      final size= MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.black100,
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
      // floatingActionButton: Container(
      //     height: 56.h,
      //     width: 56.h,
      //     padding: EdgeInsets.all(16.h),
      //     decoration: const BoxDecoration(
      //       shape: BoxShape.circle,
      //       gradient: LinearGradient(
      //         colors: [AppColor.primary100,AppColor.primary10],
      //         stops: [0.0, 1.0,],
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //       ),
      //    ),
      //     child: Image.asset(uLogo,)),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //
    // bottomNavigationBar: ClipPath(
    //   // clipBehavior: Clip.antiAliasWithSaveLayer,
    //   clipper: CustomShapeClipper(),
    //   child: Container(
    //     height: 83.h,
    //     color: AppColor.black0,
    //     child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               bottomNavItem(home_active,"Home", true),
    //               bottomNavItem(transaction_inactive,"Transaction", false),
    //               bottomNavItem(wallet_inactive,"Fund Wallet", false),
    //               bottomNavItem(profile_inactive,"Profile", false),
    //             ],
    //           ),
    //   ),
    // ),
    );
  }
  Widget bottomNavItem(String icon, String title, bool isActive){
    return SizedBox(
      height: 46.h,
      width: 70.w,
      child: Column(
        children: [
          SvgPicture.asset(icon,color: isActive?AppColor.primary100:AppColor.primary60,),
          Text(title, style: CustomTextStyle.kTxtMedium.copyWith(
            color: isActive?AppColor.primary100:AppColor.primary60,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400
          ),)
        ],
      ),
    );
  }
}
