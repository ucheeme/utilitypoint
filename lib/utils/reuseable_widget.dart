import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:utilitypoint/utils/app_color_constant.dart';
import 'package:utilitypoint/utils/text_style.dart';

class CustomButton extends StatelessWidget {

  CustomButton({
    required this.onTap,
    this.borderRadius,

    this.buttonColor,

    this.textColor,

    this.borderColor,

    required this.buttonText,
    this.height,
    this.width,
    this.textfontSize,
    Key? key,

  }) : super(key: key);


  VoidCallback onTap;

  Color? buttonColor;

  double? borderRadius;

  Color? textColor;

  String buttonText;

  Color? borderColor;
  double? width;
  double ? height;
  double? textfontSize;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(

          color: buttonColor ?? Colors.white,

          border: Border.all(color: borderColor ?? Colors.transparent),

          borderRadius: BorderRadius.circular(borderRadius ?? 0)),

      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w400,
                fontSize: textfontSize ?? 16.sp,
                fontFamily: 'Gilroy-Bold',),

            ),

          ),

        ),

      ),

    );
  }

}

class CustomAppBar extends StatelessWidget {
  String title;

  CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.back(canPop: false);
          },
          child: Container(
            height: 40.h,
            width: 40.w,
            padding: EdgeInsets.only(left: 4.w,),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColor.black0,)
            ),
            child: Icon(Icons.arrow_back_ios, color: AppColor.black0,size:21 ,),
          ),
        ),
        Gap(32.w),
        Text(title, style: CustomTextStyle.kTxtBold.copyWith(
            color: AppColor.black0,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400
        ),)
      ],
    );
  }
}

class CustomizedTextField extends StatelessWidget {
  final TextEditingController ? textEditingController;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String ? labeltxt;
  final String ? hintTxt;
  final bool ? obsec;
  bool? isConfirmPasswordMatch;
  final Widget ? surffixWidget;
  final Function(String)? onChanged;
  final bool? readOnly;
  bool? isPasswordVisible;
  bool isTouched = false;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final int? maxLines;
  final int?maxLength;
  final String? suffixText;
  final Widget? prefixWidget;
  final String? prefix;
  final Function()? onEditingComplete;
  String? error;
  final List<TextInputFormatter>? inputFormat;


  CustomizedTextField({super.key, this.prefix, this.prefixWidget,
    this.prefixIconConstraints, this.error, this.isConfirmPasswordMatch,
    this.onEditingComplete,
    this.maxLines, this.textEditingController,
    this.keyboardType, this.textInputAction, this.labeltxt, this.hintTxt,
    this.obsec, this.surffixWidget, this.inputFormat, this.readOnly,
    this.onChanged, this.validator, this.onTap, this.suffixIconConstraints,
    this.maxLength, this.suffixText, required this.isTouched,
    this.isPasswordVisible});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      obscureText: obsec ?? false,
      textCapitalization: TextCapitalization.sentences,
      controller: textEditingController,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      readOnly: readOnly ?? false,
      onTap: onTap,
      textInputAction: textInputAction,
      inputFormatters: inputFormat ?? [],
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      validator: validator ?? (value) {
        if (value!.isEmpty) {
          return "Fill empty field";
        } else {
          return null;
        }
      },
      style: CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black100,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp),
      decoration: InputDecoration(
          hintText: hintTxt,
          contentPadding: EdgeInsets.symmetric(vertical: 15.h),
          hintTextDirection: TextDirection.ltr,
          isDense: true,
          suffixText: suffixText,
          prefixText: prefix,
          prefixIcon: prefixWidget ?? const SizedBox.shrink(),
          prefixIconConstraints: suffixIconConstraints ??
               BoxConstraints(minWidth: 19.w, minHeight: 19.h,),
          suffixIconConstraints: suffixIconConstraints ??
               BoxConstraints(minWidth: 19.w, minHeight: 19.h),
          suffixIcon: surffixWidget ?? const SizedBox.shrink(),
          fillColor: isTouched ? AppColor.primary20 : AppColor.black0,
          filled: true,
          errorText: error,
          errorStyle: CustomTextStyle.kTxtMedium.copyWith(
              color: (isConfirmPasswordMatch != null &&
                  isConfirmPasswordMatch == false)
                  ? AppColor.success100
                  : AppColor.Error100, fontSize: 10.sp),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary100, width: 0.5.w),
            borderRadius: BorderRadius.circular(4.r),),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.black40),
            borderRadius: BorderRadius.circular(4.r),),
          errorBorder: (error == null || error == "")
              ? null
              : OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.Error100, width: 0.2.w),
            borderRadius: BorderRadius.circular(4.r),),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.black80),
            borderRadius: BorderRadius.circular(4.r),),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary100, width: 0.5.w),
            borderRadius: BorderRadius.circular(4.r),),
          hintStyle: CustomTextStyle.kTxtRegular.copyWith(
              color: const Color(0xff79747E),
              fontWeight: FontWeight.w400,
              fontSize: 13.sp)
      ),
    );
  }
}

Container appBodyDesign(Widget bodyDesign) {
  return Container(
    width: Get.width,
    height: Get.height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColor.primary100, AppColor.primary10],
        stops: [0.0, 1.0,],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: bodyDesign,
  );
}
