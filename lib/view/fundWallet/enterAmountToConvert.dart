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
import '../../utils/image_paths.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/text_style.dart';
import '../menuOption/convertFunds/convert.dart';


class EnterUsdAmountScreen extends StatefulWidget {
  ScrollController controller;
  EnterUsdAmountScreen({super.key,required this.controller});

  @override
  State<EnterUsdAmountScreen> createState() => _EnterUsdAmountScreenState();
}

class _EnterUsdAmountScreenState extends State<EnterUsdAmountScreen> {
  String amount ="0";
  TextEditingController amountController = TextEditingController();
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
            Gap(26.h),
            Text(
              'Enter USD Amount',
              textAlign: TextAlign.center,
              style:CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black100,
                  fontSize: 14.sp,fontWeight: FontWeight.w400),
            ),
            Gap(18.h),
            Center(
              child: Text(
                NumberFormat.currency(
                    symbol:'\$', decimalDigits: 2)
                    .format(double.parse(amount)),
                style: GoogleFonts.inter(
                    color: AppColor.black100,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.sp),
              ),
            ),
            Gap(16.h),
            Text(
              "Amount must be between '\$2' and \$2000",
              textAlign: TextAlign.center,
              style:CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black80,
                  fontSize: 14.sp,fontWeight: FontWeight.w400),
            ),
            Gap(41.h),
            SizedBox(
              height: 270.h,
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 45.h,
                    width: 257.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: (){
                            _input("1");
                          },
                          child:Text(
                            "1",
                            textAlign: TextAlign.center,
                            style:CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black100,
                                fontSize: 20.sp,fontWeight: FontWeight.w400),
                          ),),
                        TextButton(
                          onPressed: (){
                            _input("2");
                          },
                          child:Text(
                            "2",
                            textAlign: TextAlign.center,
                            style:CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black100,
                                fontSize: 20.sp,fontWeight: FontWeight.w400),
                          ),),
                        TextButton(
                          onPressed: (){
                            _input("3");
                          },
                          child:Text(
                            "3",
                            textAlign: TextAlign.center,
                            style:CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black100,
                                fontSize: 20.sp,fontWeight: FontWeight.w400),
                          ),),
                      ],
                    ),
                  ),
                  Gap(30.h),
                  SizedBox(

                    height: 40.h,
                    width: 257.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: (){
                            _input("4");
                          },
                          child:Text(
                            "4",
                            textAlign: TextAlign.center,
                            style:CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black100,
                                fontSize: 20.sp,fontWeight: FontWeight.w400),
                          ),),
                        TextButton(
                          onPressed: (){
                            _input("5");
                          },
                          child:Text(
                            "5",
                            textAlign: TextAlign.center,
                            style:CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black100,
                                fontSize: 20.sp,fontWeight: FontWeight.w400),
                          ),),
                        TextButton(
                          onPressed: (){
                            _input("6");
                          },
                          child:Text(
                            "6",
                            textAlign: TextAlign.center,
                            style:CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black100,
                                fontSize: 20.sp,fontWeight: FontWeight.w400),
                          ),),
                      ],
                    ),
                  ),
                  Gap(30.h),
                  SizedBox(
                    height: 40.h,
                    width: 257.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: (){
                            _input("7");
                          },
                          child:Text(
                            "7",
                            textAlign: TextAlign.center,
                            style:CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black100,
                                fontSize: 20.sp,fontWeight: FontWeight.w400),
                          ),),
                        TextButton(
                          onPressed: (){
                            _input("8");
                          },
                          child:Text(
                            "8",
                            textAlign: TextAlign.center,
                            style:CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black100,
                                fontSize: 20.sp,fontWeight: FontWeight.w400),
                          ),),
                        TextButton(
                          onPressed: (){
                            _input("9");
                          },
                          child:Text(
                            "9",
                            textAlign: TextAlign.center,
                            style:CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black100,
                                fontSize: 20.sp,fontWeight: FontWeight.w400),
                          ),),
                      ],
                    ),
                  ),
                  Gap(30.h),
                  SizedBox(
                    height: 40.h,
                    width: 257.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: (){
                            _input("00");
                          },
                          child:Text(
                            "00",
                            textAlign: TextAlign.center,
                            style:CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black100,
                                fontSize: 20.sp,fontWeight: FontWeight.w400),
                          ),),
                        TextButton(
                          onPressed: (){
                            _input("0");
                          },
                          child:Text(
                            "0",
                            textAlign: TextAlign.center,
                            style:CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black100,
                                fontSize: 20.sp,fontWeight: FontWeight.w400),
                          ),),
                        GestureDetector(
                          onTap: (){
                            _backspace();
                          },
                          child: SvgPicture.asset("assets/image/icons/removeValues.svg"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(35.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 34.w),
              child: CustomButton(
                onTap: () async {
                  if(double.parse(amount)>2){
                    showSlidingModalCreate(context,amount);
                  }else{
                    AppUtils.showInfoSnack(
                        "Amount must be greater than 2",
                        context);
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
            TextButton(
              onPressed: (){
                Get.back();
              },
              child:Text(
                "Go back",
                textAlign: TextAlign.center,
                style:CustomTextStyle.kTxtMedium.copyWith(color: AppColor.secondary100,
                    fontSize: 14.sp,fontWeight: FontWeight.w400),
              ),),
          ],
        ),
      ),
    );
  }
  void _input(String text) {
    final value = amountController.text + text;
    if(amountController.text.length!=4){
      amountController.text = value;
      setState(() {
        amount=value;
      });
    }
  }
  void _backspace() {
    final value = amountController.text;
    if (value.isNotEmpty) {
      amountController.text = value.substring(0, value.length - 1);
      setState(() {
        amount=amountController.text;
        if (amount.isEmpty){
          amount="0";
        }
      });
    }
  }
}
