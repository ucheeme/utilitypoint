import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:utilitypoint/utils/text_style.dart';
import 'package:utilitypoint/view/home/moreOptions.dart';
import 'package:utilitypoint/view/menuOption/convertFunds/convert.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../utils/app_color_constant.dart';
import '../../utils/customClipPath.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.primary20,
      body: ListView(
        padding: EdgeInsets.zero,
        // mainAxisAlignment: MainAxisAlignment.start ,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dashboardHeader(accountBalance:double.parse(loginResponse!.nairaWallet), isNaira: true,
          sideBarOnTap: (){
            Navigator.of(context).push(createFlipRoute(Moreoptions()));
          }),
          Gap(32.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Quick Access",
                style: CustomTextStyle.kTxtBold.copyWith(
                  color: AppColor.black100,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),),
                Gap(18.h),
                SizedBox(
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      dashboardIcons(horizontal: 0,onTap: (){}),
                      dashboardIcons(title: "Withdraw",icon: "withdraw",onTap: (){}),
                      dashboardIcons(title: "Dollar Card",icon: "dollardCard",onTap: (){}),
                      dashboardIcons(title: "Covert",icon: "convert",onTap: (){
                        Get.to(ConvertScreen());
                      }),
                    ],
                  ),
                ),
                Gap(18.h),
                SizedBox(
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      dashboardIcons(horizontal: 0,title:"Buy Airtime",icon:"buyAirtime",onTap: (){}),
                      dashboardIcons(title: "Cable TV",icon: "cableTv",onTap: (){}),
                      dashboardIcons(title: "Electricity",icon: "electricity",onTap: (){}),
                      dashboardIcons(title: "More",icon:"more_icon",onTap: (){}),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Gap(28.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Image.asset("assets/image/images_png/Card.png"),
          )
       ],
      ),
    );
  }
}
