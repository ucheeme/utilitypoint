import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:utilitypoint/utils/reuseable_widget.dart';
import 'package:utilitypoint/view/menuOption/convertFunds/reviewOrder.dart';

import '../../../bloc/card/virtualcard_bloc.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/reuseableFunctions.dart';
import '../../../utils/text_style.dart';
import '../../bottomsheet/currencyOptions.dart';

class ConvertScreen extends StatefulWidget {
  const ConvertScreen({super.key});

  @override
  State<ConvertScreen> createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen>
    with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  TextEditingController amountToConvertController = TextEditingController();
  TextEditingController amountConvertedController = TextEditingController();
  String valueToConvert = "";
  String currencyConvertingFrom = "";
  String currencyConvertingTo = "";
  bool isSelected = false;
  bool isSelectedTo = false;
  late VirtualcardBloc bloc;

  @override
  void initState() {
    currencyConvertingFrom = "NGN";
    currencyConvertingTo = "USD";
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      amountToConvertController.addListener(onTextChanged);
      amountConvertedController.addListener(onTextChanged2);
    });
    // Initialize the SlideAnimationManager
    _animationManager = SlideAnimationManager(this);
  }

  void onTextChanged() {
    final text = amountToConvertController.text;
    final newText = formatWithCommas(text);
    if (newText != text) {
      amountToConvertController.value =
          amountToConvertController.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  void onTextChanged2() {
    final text = amountConvertedController.text;
    final newText = formatWithCommas(text);
    if (newText != text) {
      amountConvertedController.value =
          amountConvertedController.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  @override
  void dispose() {
    // Dispose the animation manager to avoid memory leaks
    _animationManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appBodyDesign(getBody()),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SlideTransition(
            position: _animationManager.slideAnimationTop,
            child: Padding(
              padding: EdgeInsets.only(top: 52.h, left: 20.w, bottom: 17.h),
              child:
                  SizedBox(height: 52.h, child: CustomAppBar(title: "Convert")),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _animationManager.slideAnimation,
            child: Container(
              height: 668.72.h,
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 24.w),
              decoration: BoxDecoration(
                color: AppColor.primary20,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200.h,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected = true;
                                isSelectedTo = false;
                              });
                            },
                            child: convertContainer(
                                currency: currencyConvertingFrom,
                                changeCurrency: () async {
                                  dynamic response = await showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      enableDrag: true,
                                      isDismissible: true,
                                      isScrollControlled: true,
                                      context: context!,
                                      builder: (context) {
                                        return CurrencyOptions(
                                          currentCurrency:
                                              currencyConvertingFrom,
                                        );
                                      });
                                  if (response is String) {
                                    setState(() {
                                      currencyConvertingFrom = response;
                                    });
                                  }
                                },
                                isNaira:
                                    checkCurrencyFrom(currencyConvertingFrom),
                                isSelected: isSelected,
                                context: context,
                                amountController: amountToConvertController,
                                onChanged: (value) {
                                  String cost = value.replaceAll(",", "");
                                  if (value != null) {
                                    if(currencyConvertingFrom=="USD"){
                                      setState(() {
                                        valueToConvert = value;
                                        amountConvertedController.text =
                                            (double.parse(cost) * 1500)
                                                .toStringAsFixed(0);
                                      });
                                    }else{
                                      setState(() {
                                        valueToConvert = value;
                                        amountConvertedController.text =
                                            (double.parse(cost) / 1500).toString();
                                        print(amountConvertedController.text);
                                      });
                                    }

                                  } else {
                                    setState(() {
                                      valueToConvert = "";
                                      amountConvertedController.text = "0";
                                    });
                                  }
                                },
                                textFieldTouch: () {
                                  setState(() {
                                    isSelected = true;
                                    isSelectedTo = false;
                                  });
                                }),
                          ),
                          Positioned(
                            top: 105.h,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelected = false;
                                  isSelectedTo = true;
                                });
                              },
                              child: convertContainer(
                                  currency: currencyConvertingTo,
                                  changeCurrency: () async {
                                    dynamic response =
                                        await showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            enableDrag: true,
                                            isDismissible: true,
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context) {
                                              return CurrencyOptions(
                                                currentCurrency:
                                                    currencyConvertingTo,
                                              );
                                            });
                                    if (response is String) {
                                      setState(() {
                                        currencyConvertingTo = response;
                                      });
                                    }
                                  },
                                  isSelected: isSelectedTo,
                                  context: context,
                                  isNaira:
                                      checkCurrencyFrom(currencyConvertingTo),
                                  isFrom: false,
                                  textFieldTouch: () {
                                    setState(() {
                                      isSelectedTo = true;
                                      isSelected = false;
                                    });
                                  },
                                  amountController: amountConvertedController,
                                  isReadOnly: true),
                            ),
                          ),
                          Positioned(
                            top: 80.h,
                            left: 147.5.w,
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              padding: EdgeInsets.all(3.w),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.primary100),
                              child: Image.asset(
                                  "assets/image/images_png/fi_refresh.png"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(24.h),
                    SizedBox(
                      height: 54.h,
                      width: 335.w,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                            width: 335.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Buy Rate",
                                  style: CustomTextStyle.kTxtMedium.copyWith(
                                      color: AppColor.black80,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "1 USD ~ 1500 NGN",
                                  style: CustomTextStyle.kTxtMedium.copyWith(
                                      color: AppColor.black100,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          Gap(14.h),
                          SizedBox(
                            height: 20.h,
                            width: 335.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Fee",
                                  style: CustomTextStyle.kTxtMedium.copyWith(
                                      color: AppColor.black80,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "10 NGN",
                                  style: CustomTextStyle.kTxtMedium.copyWith(
                                      color: AppColor.black100,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(83.h),
                    CustomButton(
                      onTap: () {
                        converting = ConvertingData(
                            currency: currencyConvertingFrom,
                            amount: amountToConvertController.text
                                .replaceAll(",", ""));
                        receiving = ConvertingData(
                            currency: currencyConvertingTo,
                            amount: amountConvertedController.text
                                .replaceAll(",", ""));
                        Get.to(ReviewOrder());
                      },
                      buttonText: "Review Order",
                      height: 58.h,
                      textColor: AppColor.black0,
                      borderRadius: 8.r,
                      buttonColor: valueToConvert.isEmpty
                          ? AppColor.primary40
                          : AppColor.primary100,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool checkCurrencyFrom(String value) {
    if (value == "USD") {
      return false;
    } else {
      return true;
    }
  }
}
