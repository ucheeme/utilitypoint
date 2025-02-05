import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:utilitypoint/utils/app_color_constant.dart';
import 'package:utilitypoint/utils/image_paths.dart';
import 'package:utilitypoint/utils/reuseableFunctions.dart';
import 'package:utilitypoint/utils/text_style.dart';
import 'package:utilitypoint/view/bottomsheet/currencyOptions.dart';

import '../model/response/dataPlanResponse.dart';

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
    this.icon,
    this.hasIcon,
    Key? key,
  }) : super(key: key);

  VoidCallback onTap;
  IconData? icon;
  Color? buttonColor;

  double? borderRadius;

  Color? textColor;

  String buttonText;
  bool? hasIcon;
  Color? borderColor;
  double? width;
  double? height;
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                    visible: icon == null ? false : true,
                    child: Icon(
                      icon,
                      color: AppColor.black0,
                    )),
                Visibility(
                    visible: icon == null ? false : true, child: Gap(5.w)),
                Text(
                  buttonText,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w400,
                    fontSize: textfontSize ?? 16.sp,
                    fontFamily: 'Gilroy-Bold',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  String title;
  bool? isBottomNav;

  CustomAppBar({super.key, required this.title, this.isBottomNav});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: Visibility(
            visible: isBottomNav == true ? false : true,
            child: Container(
              height: 40.h,
              width: 40.w,
              padding: EdgeInsets.only(
                left: 4.w,
              ),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: AppColor.black0,
                  )),
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColor.black0,
                size: 21,
              ),
            ),
          ),
        ),
        Gap(32.w),
        Text(
          title,
          style: CustomTextStyle.kTxtBold.copyWith(
              color: AppColor.black0,
              fontSize: 20.sp,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}

class SearchTransactionHistory extends StatelessWidget {
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final String? labeltxt;
  final String? hintTxt;
  final Widget? surffixWidget;
  final Function(String)? onChanged;
  final void Function()? onTap;
  final BoxConstraints? suffixIconConstraints;
  final String? suffixText;

  final List<TextInputFormatter>? inputFormat;

  const SearchTransactionHistory(
      {super.key,
      this.onTap,
      this.onChanged,
      this.keyboardType,
      this.hintTxt,
      this.inputFormat,
      this.labeltxt,
      this.suffixIconConstraints,
      this.suffixText,
      this.surffixWidget,
      this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      controller: textEditingController,
      keyboardType: keyboardType,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      onTap: onTap,
      inputFormatters: inputFormat ?? [],
      onChanged: onChanged,
      style: CustomTextStyle.kTxtMedium.copyWith(
          color: AppColor.black100,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp),
      decoration: InputDecoration(
          hintText: hintTxt,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
          //hintTextDirection: TextDirection.LTR,
          isDense: true,
          suffixIconConstraints: suffixIconConstraints ??
              BoxConstraints(minWidth: 19.w, minHeight: 19.h),
          prefixIcon: surffixWidget ?? const SizedBox.shrink(),
          fillColor: AppColor.black0,
          filled: true,
          suffixText: suffixText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary100, width: 0.5.w),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.black0),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r)),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.black0),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary100, width: 0.5.w),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r)),
          ),
          hintStyle: CustomTextStyle.kTxtRegular.copyWith(
              color: const Color(0xff79747E),
              fontWeight: FontWeight.w400,
              fontSize: 16.sp)),
    );
  }
}

class CustomizedTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? labeltxt;
  final String? hintTxt;
  final bool? obsec;
  bool? isConfirmPasswordMatch;
  final Widget? surffixWidget;
  final Function(String)? onChanged;
  final bool? readOnly;
  bool? isPasswordVisible;
  bool? isTouched = false;
  bool? isProfile = false;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final int? maxLines;
  final int? maxLength;
  final String? suffixText;
  final Widget? prefixWidget;
  final String? prefix;
  final Function()? onEditingComplete;
  String? error;
  final List<TextInputFormatter>? inputFormat;

  CustomizedTextField(
      {super.key,
      this.isProfile,
      this.prefix,
      this.prefixWidget,
      this.prefixIconConstraints,
      this.error,
      this.isConfirmPasswordMatch,
      this.onEditingComplete,
      this.maxLines,
      this.textEditingController,
      this.keyboardType,
      this.textInputAction,
      this.labeltxt,
      this.hintTxt,
      this.obsec,
      this.surffixWidget,
      this.inputFormat,
      this.readOnly,
      this.onChanged,
      this.validator,
      this.onTap,
      this.suffixIconConstraints,
      this.maxLength,
      this.suffixText,
      this.isTouched,
      this.isPasswordVisible});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            autofocus: false,
            cursorColor: AppColor.primary100,
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
            validator: validator ??
                (value) {
                  if (value!.isEmpty) {
                    return "Fill empty field";
                  } else {
                    return null;
                  }
                },
            style: CustomTextStyle.kTxtMedium.copyWith(
                color: AppColor.black100,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp),
            decoration: InputDecoration(
                hintText: hintTxt,
                contentPadding: EdgeInsets.symmetric(vertical: 15.h),
                //hintTextDirection: TextDirection.LTR,
                isDense: true,
                suffixText: suffixText,
                prefixText: prefix,
                prefixIcon: prefixWidget ?? const SizedBox.shrink(),
                prefixIconConstraints: suffixIconConstraints ??
                    BoxConstraints(
                      minWidth: 19.w,
                      minHeight: 19.h,
                    ),
                suffixIconConstraints: suffixIconConstraints ??
                    BoxConstraints(minWidth: 19.w, minHeight: 19.h),
                suffixIcon: surffixWidget ?? const SizedBox.shrink(),
                fillColor: (isProfile == true)
                    ? AppColor.primary30
                    : isTouched == true
                        ? AppColor.primary20
                        : AppColor.black0,
                filled: true,
                // errorText: error,
                // errorStyle: CustomTextStyle.kTxtMedium.copyWith(
                //     color: (isConfirmPasswordMatch != null &&
                //             isConfirmPasswordMatch == false)
                //         ? AppColor.success100
                //         : AppColor.Error100,
                //     fontSize: 10.sp),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.primary100, width: 0.5.w),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.black40),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                errorBorder: (error == null || error == "")
                    ? null
                    : OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.Error100, width: 0.2.w),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.black80),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.primary100, width: 0.5.w),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                hintStyle: CustomTextStyle.kTxtRegular.copyWith(
                    color: const Color(0xff79747E),
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp)),
          ),
          Gap(4.h),
          Text(
            error ?? "",
            style: CustomTextStyle.kTxtMedium.copyWith(
                color: (isConfirmPasswordMatch != null &&
                        isConfirmPasswordMatch == false)
                    ? AppColor.success100
                    : AppColor.Error100,
                fontSize: 10.sp),
          ),
        ],
      ),
    );
  }
}

class BorderlessTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? labeltxt;
  final String? hintTxt;
  final bool? obsec;
  bool? isConfirmPasswordMatch;
  final Widget? surffixWidget;
  final Function(String)? onChanged;
  final bool? readOnly;
  bool? isPasswordVisible;
  bool isTouched = false;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final int? maxLines;
  final int? maxLength;
  final String? suffixText;
  final Widget? prefixWidget;
  final String? prefix;
  final Function()? onEditingComplete;
  String? error;
  final List<TextInputFormatter>? inputFormat;

  BorderlessTextField(
      {super.key,
      this.prefix,
      this.prefixWidget,
      this.prefixIconConstraints,
      this.error,
      this.isConfirmPasswordMatch,
      this.onEditingComplete,
      this.maxLines,
      this.textEditingController,
      this.keyboardType,
      this.textInputAction,
      this.labeltxt,
      this.hintTxt,
      this.obsec,
      this.surffixWidget,
      this.inputFormat,
      this.readOnly,
      this.onChanged,
      this.validator,
      this.onTap,
      this.suffixIconConstraints,
      this.maxLength,
      this.suffixText,
      required this.isTouched,
      this.isPasswordVisible});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: textEditingController,
      keyboardType: keyboardType,
      textAlign: TextAlign.end,
      textAlignVertical: TextAlignVertical.center,
      readOnly: readOnly ?? false,
      onTap: onTap,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return "Fill empty field";
            } else {
              return null;
            }
          },
      style: CustomTextStyle.kTxtMedium.copyWith(
          color: AppColor.black100,
          fontWeight: FontWeight.w400,
          fontSize: 16.sp),
      decoration: InputDecoration(
          hintText: hintTxt,
          contentPadding: EdgeInsets.symmetric(vertical: 15.h),
          //hintTextDirection: TextDirection.LTR,
          isDense: true,
          fillColor: isTouched ? AppColor.primary20 : AppColor.black0,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.black0, width: 0.5.w),
            // borderRadius: BorderRadius.circular(4.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.black0),
            // borderRadius: BorderRadius.circular(4.r),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.black0),
            // borderRadius: BorderRadius.circular(4.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary100, width: 0.5.w),
            // borderRadius: BorderRadius.circular(4.r),
          ),
          hintStyle: CustomTextStyle.kTxtRegular.copyWith(
              color: const Color(0xff79747E),
              fontWeight: FontWeight.w400,
              fontSize: 16.sp)),
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
        stops: [
          0.0,
          1.0,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: bodyDesign,
  );
}

Future<dynamic> openBottomSheet(BuildContext context, Widget bottomScreen,
    {background = AppColor.black0,bool isDismissible=true}) {
  return showModalBottomSheet(
      isDismissible: isDismissible,
      isScrollControlled: true,
      context: context,
      backgroundColor: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(24.r), topLeft: Radius.circular(24.r)),
      ),
      builder: (context) => Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: bottomScreen,
          ));
}

Widget dashboardHeader(
    {double accountBalance = 0,
    Function()? sideBarOnTap,
    int initialPage = 0,
    bool isVisibleAmount = false,
    Function()? onPressed,
    Function(int, CarouselPageChangedReason)? onPageChanged,
    Function()? depositOnTap,
    Function()? withdrawOnTap,
    double accountBalanceFractions = .00,
    bool isNaira = true}) {
  return Container(
      height: 266.h,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40.r),
            bottomLeft: Radius.circular(40.r)),
        gradient: LinearGradient(
          colors: [AppColor.primary100, AppColor.primary10],
          stops: [
            0.5,
            1.0,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: CarouselSlider.builder(
          itemCount: 2,
          options: CarouselOptions(
            //pageSnapping: false,
            //scrollPhysics: BouncingScrollPhysics(),
            height: 266.h,
            padEnds: false,
            disableCenter: false,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            //height: 400,
            // aspectRatio: 16/19,
            viewportFraction: 1.0,
            initialPage: initialPage,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            onPageChanged: onPageChanged,
            scrollDirection: Axis.horizontal,
          ),
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(72.h),
                SizedBox(
                  height: 40.h,
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Account balance",
                        style: CustomTextStyle.kTxtMedium.copyWith(
                            color: AppColor.black0,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                          onTap: sideBarOnTap,
                         child: Image.asset("assets/image/icons/sideBar.png")
                         //  child:  Container(
                         //    height: 50.h,
                         //    width: 50.w,
                         //    decoration: BoxDecoration(
                         //        shape: BoxShape.circle,
                         //        image: DecorationImage(image: getProfileImage() ),
                         //        // border: Border.all(
                         //        //    // color: AppColor.primary40,
                         //        //     width: 1.5.w)
                         //    ),
                         //
                         //  ),
                      ),
                    ],
                  ),
                ),
                Gap(8.h),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text:isVisibleAmount? NumberFormat.currency(
                                      symbol: isNaira ? '\₦' : '\$',
                                      decimalDigits: 0)
                                  .format(accountBalance):
                              "...",
                              style: GoogleFonts.inter(
                                  color: AppColor.black0,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 32.sp)),
                          TextSpan(
                              text:isVisibleAmount?
                                  '.${accountBalanceFractions.toStringAsFixed(2).split(".")[1]}':'...',
                              style: GoogleFonts.inter(
                                  color: AppColor.black10,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 32.sp)),
                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 2.h),
                      child: IconButton(
                          onPressed: onPressed,
                          icon: isVisibleAmount
                              ?  const Icon(Icons.visibility_off_outlined,color: AppColor.black0,)
                              : const Icon(Icons.visibility_outlined,color: AppColor.black0,)),
                    )
                  ],
                ),
                Gap(28.h),
                SizedBox(
                  height: 48.h,
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      completelyCurvedButton(depositOnTap,
                          title: isNaira ? "Deposit NGN" : "Deposit USD"),
                      Visibility(
                        visible: !isNaira,
                        child: completelyCurvedButton(withdrawOnTap,
                            icon: 'arrowDiagonalUp',
                            title: 'Wallet History',
                            buttonColor: AppColor.primary90),
                      ),
                    ],
                  ),
                )
              ],
            );
          }));
}

Widget completelyCurvedButton(Function()? onTap,
    {String icon = 'arrowDIagonalLeft',
    String title = "Deposit",
    Color buttonColor = AppColor.primary100}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 48.h,
      width: 154.w,
      padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 21.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r), color: buttonColor),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: 20.h,
              width: 19.w,
              child: Image.asset("assets/image/icons/$icon.png")),
          Text(
            title,
            style: CustomTextStyle.kTxtMedium.copyWith(
                color: AppColor.black0,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    ),
  );
}

Widget dashboardIcons(
    {String title = "Fund Wallet",
    String icon = 'fund_wallet',
    Function()? onTap,
    bool isSelected = false,
    double horizontal = 5}) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      height: 100.h,
      // width: 74.w,
      child: Column(
        children: [
          Container(
            height: 56.h,
            width: 56.w,
            padding: EdgeInsets.all(16.h),
            decoration: BoxDecoration(
                border: Border.all(
                    color: isSelected ? AppColor.primary100 : AppColor.black0),
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.black0),
            child: Image.asset(
              "assets/image/icons/$icon.png",
              fit: BoxFit.contain,
            ),
          ),
          Gap(10.h),
          Text(
            title,
            style: CustomTextStyle.kTxtMedium.copyWith(
                color: AppColor.black100,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    ),
  );
}

Widget dataCard(ProductPlanItemResponse response, bool selectedOption) {
  return Container(
    height: 100.h,
    width: 90.w,
    //margin: EdgeInsets.symmetric(vertical: 16.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
          color: selectedOption ? AppColor.secondary100 : AppColor.black0),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 8)),
      ],
      color: AppColor.black0,
    ),
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
          child: Text(
            response.dataSizeInMb == null
                ? extractSizeValue(response.productPlanName)
                : getDataValue(double.parse(response.dataSizeInMb)),
            style: CustomTextStyle.kTxtBold.copyWith(
                color: AppColor.black100,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        Center(
          child: Text(
            "${response.validityInDays} Days",
            style: CustomTextStyle.kTxtMedium.copyWith(
                color: AppColor.black60,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        Center(
          child: Text(
            NumberFormat.currency(symbol: '\₦', decimalDigits: 0)
                .format(double.parse(response.sellingPrice.toString())),
            style: GoogleFonts.inter(
                color: AppColor.secondary100,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        // Center(
        //   child: Text(
        //     response.sellingPrice,
        //     style: CustomTextStyle.kTxtMedium.copyWith(
        //         color: AppColor.secondary100,
        //         fontSize: 10.sp,
        //         fontWeight: FontWeight.w400),
        //   ),
        // ),
      ],
    ),
  );
}

Widget cablePlanCard(ProductPlanItemResponse response, bool selectedOption) {
  return Container(
    height: 120.h,
    width: 90.w,
    //margin: EdgeInsets.symmetric(vertical: 16.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
          color: selectedOption ? AppColor.secondary100 : AppColor.black0),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 8)),
      ],
      color: AppColor.black0,
    ),
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
          child: Text(
            response.productPlanName,
            style: CustomTextStyle.kTxtBold.copyWith(
                color: AppColor.black100,
                fontSize: 8.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        Center(
          child: Text(
            "${response.validityInDays} Days",
            style: CustomTextStyle.kTxtMedium.copyWith(
                color: AppColor.black60,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        Center(
          child: Text(
            NumberFormat.currency(symbol: '\₦', decimalDigits: 0)
                .format(double.parse(response.sellingPrice.toString())),
            style: GoogleFonts.inter(
                color: AppColor.secondary100,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        // Center(
        //   child: Text(
        //     response.sellingPrice,
        //     style: CustomTextStyle.kTxtMedium.copyWith(
        //         color: AppColor.secondary100,
        //         fontSize: 10.sp,
        //         fontWeight: FontWeight.w400),
        //   ),
        // ),
      ],
    ),
  );
}

Widget airtimeCard({String title = ""}) {
  return Container(
    height: 63.h,
    width: 70.w,
    margin: EdgeInsets.symmetric(vertical: 16.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 8)),
      ],
      color: AppColor.black0,
    ),
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    child: Center(
      child: Text(
        title,
        style: CustomTextStyle.kTxtMedium.copyWith(
            color: AppColor.black100,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400),
      ),
    ),
  );
}

Widget listButtons(
    {String title = "",
    String icons = "",
    bool hasSwitch = false,
    bool isNotification = false,
    String notifications = "0",
    bool switchValue = false,
    Function(bool)? onChanged}) {
  return Container(
      height: 50.h,
      width: 335.w,
      margin: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 8)),
        ],
        color: AppColor.black0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 9.5.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 24.h,
            width: icons == "" ? 250.w : null,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: icons == "" ? false : true,
                  child: Image.asset(
                    "assets/image/icons/$icons.png",
                    color: title == "My Accounts" ? AppColor.primary100 : null,
                  ),
                ),
                Visibility(
                    visible: icons == "" ? false : true, child: Gap(8.w)),
                Center(
                  child: Text(
                    title,
                    style: CustomTextStyle.kTxtMedium.copyWith(
                        color: AppColor.black100,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          hasSwitch
              ? Switch(
                  inactiveTrackColor: AppColor.black40,
                  activeTrackColor: AppColor.primary100,
                  value: switchValue,
                  onChanged: onChanged)
              : isNotification
                  ? Container(
                      height: 44.h,
                      padding: EdgeInsets.all(6.h),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColor.secondary100),
                      child: Center(
                        child: Text(
                          notifications,
                          style: CustomTextStyle.kTxtMedium.copyWith(
                              color: AppColor.black0,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp),
                        ),
                      ),
                    )
                  : Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColor.black60,
                      size: 18.h,
                    )
        ],
      ));
}

Widget cardDesign(
    {double accountBalance = 0,
    double balanceRemaining = .00,
    String cardNumber = "",
    bool isNaira = true,
    Function()? copyCTA,
    Function()? cardCTA}) {
  return GestureDetector(
    onTap: cardCTA,
    child: Container(
      height: 128.h,
      width: 335.w,
      margin: EdgeInsets.symmetric(vertical: 16.h),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primary100, AppColor.primary10],
            stops: [
              0.0,
              1.0,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Account balance",
            style: CustomTextStyle.kTxtMedium.copyWith(
                color: AppColor.black10,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 40.h,
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: NumberFormat.currency(
                                  symbol: isNaira ? '\₦' : '\$',
                                  decimalDigits: 0)
                              .format(accountBalance),
                          style: GoogleFonts.inter(
                              color: AppColor.black0,
                              fontWeight: FontWeight.w600,
                              fontSize: 28.sp)),
                      TextSpan(
                          text:
                              '.${balanceRemaining.toStringAsFixed(2).split(".")[1]}',
                          style: GoogleFonts.inter(
                              color: AppColor.black10,
                              fontWeight: FontWeight.w600,
                              fontSize: 22.sp)),
                    ],
                  ),
                ),
                isNaira
                    ? Image.asset(
                        "assets/image/images_png/flags.png",
                        height: 24.h,
                        width: 32.w,
                      )
                    : Image.asset(
                        "assets/image/images_png/us_flage.png",
                        height: 24.h,
                        width: 32.w,
                      )
              ],
            ),
          ),
          Gap(11.h),
          SizedBox(
            height: 17.h,
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isNaira ? "NGN Naira" : "USD Dollars",
                  style: CustomTextStyle.kTxtMedium.copyWith(
                      color: AppColor.black10,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 17.h,
                  width: 109.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cardNumber,
                        style: CustomTextStyle.kTxtMedium.copyWith(
                            color: AppColor.black10,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      // Gap(10.w),
                      // GestureDetector(
                      //     onTap: copyCTA,
                      //     child: Image.asset(
                      //         "assets/image/images_png/copy_ic.png"))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget convertContainer(
    {bool isSelected = false,
    bool isNaira = false,
    double accountBalance = 0,
    String currency = "USD",
    Function(String)? onChanged,
    Function()? changeCurrency,
    bool isFrom = true,
    bool isReadOnly = false,
    Function()? textFieldTouch,
    TextEditingController? amountController,
    BuildContext? context}) {
  return Container(
    height: 90.h,
    width: 335.w,
    padding: EdgeInsets.all(12.h),
    decoration: BoxDecoration(
      color: AppColor.black0,
      borderRadius: BorderRadius.circular(16.r),
      border:
          Border.all(color: isSelected ? AppColor.primary100 : AppColor.black0),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 5)),
      ],
    ),
    child: Column(
      children: [
        SizedBox(
          height: 15.h,
          width: 295.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isFrom ? "From" : "To",
                style: CustomTextStyle.kTxtMedium.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black80),
              ),
              Text(
                isFrom
                    ? "Account Balance ${NumberFormat.currency(symbol: isNaira ? '\₦' : '\$', decimalDigits: 0).format(accountBalance)}"
                    : "",
                style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black80),
              ),
            ],
          ),
        ),
        Gap(4.h),
        SizedBox(
            width: 295.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 44.h,
                  width: 125.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      isNaira
                          ? Image.asset(
                              "assets/image/images_png/flags.png",
                              height: 35.h,
                              width: 32.w,
                            )
                          : Image.asset(
                              "assets/image/images_png/us_flage.png",
                              height: 35.h,
                              width: 32.w,
                            ),
                      Gap(6.w),
                      SizedBox(
                        height: 42.h,
                        width: 75.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: changeCurrency,
                              child: Row(
                                children: [
                                  Text(
                                    "$currency",
                                    style: CustomTextStyle.kTxtBold.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.black100),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down_outlined,
                                    color: AppColor.black100,
                                  )
                                ],
                              ),
                            ),
                            Text(
                              isNaira ? "Nigerian Naira" : "US Dollar",
                              style: CustomTextStyle.kTxtMedium.copyWith(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black100),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 35.h,
                  width: 170.w,
                  // color: Colors.red,
                  child: BorderlessTextField(
                    isTouched: false,
                    onTap: textFieldTouch,
                    hintTxt: "0",
                    keyboardType: TextInputType.number,
                    onChanged: onChanged,
                    readOnly: isReadOnly,
                    textEditingController: amountController,
                  ),
                )
              ],
            ))
      ],
    ),
  );
}

String nairaSymbol = '₦';

String dollarSymbol = '\$';
