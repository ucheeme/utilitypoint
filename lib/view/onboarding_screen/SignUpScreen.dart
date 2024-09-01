import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:utilitypoint/utils/height.dart';
import 'package:utilitypoint/utils/image_paths.dart';
import 'package:utilitypoint/utils/reuseable_widget.dart';
import 'package:utilitypoint/utils/text_style.dart';

import '../../utils/app_color_constant.dart';

class SignUpCreateAccountScreen extends StatefulWidget {
  const SignUpCreateAccountScreen({super.key});

  @override
  State<SignUpCreateAccountScreen> createState() => _SignUpCreateAccountScreenState();
}

class _SignUpCreateAccountScreenState extends State<SignUpCreateAccountScreen> {
  bool isEmailSelected = false;
  bool isPasswordSelected = false;
  bool isConfirmPasswordSelected = false;
  bool isPasswordVisible=false;
  bool isConfirmPasswordVisible=false;
  bool isEightCharacterMinimumChecked = false;
  bool isContainsNumChecked = false;
  bool isContainsSymbolChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primary100,AppColor.primary10],
            stops: [0.0, 1.0,],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(

            children: [
              Padding(
                padding:  EdgeInsets.only(top: 42.h,left: 20.w,bottom: 17.h),
                child: SizedBox(
                    height: 52.h,
                    child: CustomAppBar(title: "Create your account")),
              ),
              Gap(20.h),
              Container(
                height: 678.72.h,
                padding: EdgeInsets.symmetric(vertical: 36.h,horizontal: 24.w),
                decoration: BoxDecoration(
                  color: AppColor.black0,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: SizedBox(
                  height: 388.h,
                  width: 327.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Email Address", style: CustomTextStyle.kTxtMedium.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp
                      ),),
                      height8,
                      CustomizedTextField(
                        hintTxt: "Enter email address", isTouched: isEmailSelected,
                        onTap: (){
                          setState(() {
                            isPasswordSelected=false;
                            isConfirmPasswordSelected= false;
                            isEmailSelected=!isEmailSelected;
                          });
                        },
                      ),
                      height16,
                      Text("Password", style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.black100,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp
                      ),),
                      height8,
                      CustomizedTextField(
                        surffixWidget: GestureDetector(
                          onTap: (){
                           setState(() {
                             isConfirmPasswordSelected= false;
                             isEmailSelected=false;
                             isPasswordSelected=true;
                             isPasswordVisible=!isPasswordVisible;
                           });
                          },
                          child:Padding(
                            padding:  EdgeInsets.only(right: 16.w),
                            child: isPasswordVisible? Icon(
                              Icons.remove_red_eye_outlined,
                              size: 30,
                              color: AppColor.black100,
                            ):Image.asset(
                              ic_eye_close,
                              height: 24.h,
                              width: 24.h,
                            ),
                          ),
                        ),
                        obsec:isPasswordVisible,
                        onTap: (){
                          setState(() {
                            isConfirmPasswordSelected= false;
                            isEmailSelected=false;
                            isPasswordSelected=!isPasswordSelected;
                          });
                        }, isTouched: isPasswordSelected,
                      ),
                      height16,
                      SizedBox(
                        height: 68.h,
                        width: Get.width,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                MSHCheckbox(value:isEightCharacterMinimumChecked,
                                    onChanged: (value){}),

                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
