import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../bloc/card/virtualcard_bloc.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/app_util.dart';
import '../../utils/height.dart';
import '../../utils/image_paths.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/text_style.dart';
import '../menuOption/convertFunds/convert.dart';


class ChooseFundingMethodDesign extends StatefulWidget {
  ScrollController controller;
  ChooseFundingMethodDesign({super.key, required this.controller});

  @override
  State<ChooseFundingMethodDesign> createState() => _ChooseFundingMethodDesignState();
}

class _ChooseFundingMethodDesignState extends State<ChooseFundingMethodDesign> {
  bool isUser=false;
  bool isNGNWallet=false;
  bool isBankTransfer=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(left: 12.w,right: 12.w,bottom: 42.h),
        decoration: BoxDecoration(
          color: AppColor.primary20,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: ListView(

          controller: widget.controller, // For scrollable content
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: SizedBox(
                    height: 24.h,
                    width: 24.w,
                    child: Image.asset(closeImage)),
              ),
            ),
            height10,
            SizedBox(
              height: 50.h,
              width: 50.w,
              child: Image.asset(walletIcon,),
            ),
            Gap(24.h),
            Text(
              'Choose Funding Method',
              textAlign: TextAlign.center,
              style:CustomTextStyle.kTxtBold.copyWith(color: AppColor.black100,
                  fontSize: 20.sp,fontWeight: FontWeight.w400),
            ),
            Gap(21.h),
            GestureDetector(
              onTap: (){
                setState(() {
                  isUser=true;
                  isNGNWallet=false;
                  isBankTransfer =false;
                });
              },
              child: Container(
                height: 70.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                margin: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  border: Border.all(color:isUser?AppColor.primary100:AppColor.black60),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 8)),
                  ],
                  color: isUser?AppColor.primary30:AppColor.black0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Receive via your username",
                        style: CustomTextStyle.kTxtBold.copyWith(
                            color:isUser?AppColor.primary100:AppColor.black100,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text("Get funds from users with your username",
                      style: GoogleFonts.inter(
                          color: AppColor.black80,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  isUser=false;
                  isNGNWallet=true;
                  isBankTransfer =false;
                });
              },
              child: Container(
                height: 70.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                margin: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: isNGNWallet?AppColor.primary100:AppColor.black60),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 8)),
                  ],
                  color: isNGNWallet?AppColor.primary30:AppColor.black0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Convert from NGN Wallet",
                        style: CustomTextStyle.kTxtBold.copyWith(
                            color: isNGNWallet?AppColor.primary100:AppColor.black100,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text("You will be charged ${currencyConversionRateFees!.feeRatePerCurrency}USD for every dollar you convert",
                      style: GoogleFonts.inter(
                          color: AppColor.black80,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap:(){
                setState(() {
                  isUser=false;
                  isNGNWallet=false;
                  isBankTransfer =true;
                });
              },
              child: Container(
                height: 70.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                margin: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  border: Border.all(
                      color:isBankTransfer?AppColor.primary100: AppColor.black60),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 8)),
                  ],
                  color:isBankTransfer?AppColor.primary30: AppColor.black0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Deposit via Bank Transfer",
                        style: CustomTextStyle.kTxtBold.copyWith(
                            color:isBankTransfer?AppColor.primary100:AppColor.black100,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text("1% Fee Applies",
                      style: GoogleFonts.inter(
                          color: AppColor.black80,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
            Gap(35.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 34.w),
              child: CustomButton(
                onTap: () async {
                  if(isUser||isBankTransfer){
                    AppUtils.showInfoSnackFromBottom("Coming Soon", context);
                  }else{
                    showSlidingModalConvertNGN(context);
                  }
                },
                buttonText:'Continue',
                buttonColor: AppColor.primary100,
                textColor: AppColor.black0,
                borderRadius: 8.r,
                height: 46.h,
                width: 222.w,
              ),
            ),

          ],
        ),
      ) ,
    );
  }
}
