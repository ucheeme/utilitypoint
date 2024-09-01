import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color_constant.dart';

class CustomTextStyle{
  static TextStyle kTxtRegular = TextStyle(
    color: AppColor.black100,
    fontSize: 12.sp,
    fontFamily: 'Gilroy-Regular',
  );

  static TextStyle kTxtMedium = TextStyle(
    color:AppColor.black100,
    fontSize: 16.sp,
    fontFamily: 'Gilroy-Medium',
  );

  static TextStyle kTxtLight = TextStyle(
    color: AppColor.black100,
    fontSize: 18.sp,
    fontFamily: 'Gilroy-Light',
  );
  static TextStyle kTxtBold= TextStyle(
    color: AppColor.black100,
    fontSize: 38.sp,
    fontFamily: 'Gilroy-Bold',
  );
}