import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color_constant.dart';

class CustomTextStyle{
  static TextStyle kTxtRegular = TextStyle(
    color: AppColor.black100,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'Gilroy-Regular',
  );

  static TextStyle kTxtMedium = TextStyle(
    color:AppColor.black100,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    fontFamily: 'Gilroy-Medium',
  );

  static TextStyle kTxtLight = TextStyle(
    color: AppColor.black100,
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'Gilroy-Light',
  );
  static TextStyle kTxtBold= TextStyle(
    color: AppColor.black100,
    fontSize: 38.sp,
    fontWeight: FontWeight.w800,
    fontFamily: 'Gilroy-Bold',
  );
}