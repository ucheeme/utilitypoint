import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:utilitypoint/utils/app_color_constant.dart';
import 'package:utilitypoint/utils/app_util.dart';
import 'package:utilitypoint/utils/reOccurringWidgets/transactionPin.dart';
import 'package:utilitypoint/utils/text_style.dart';

import '../../../bloc/card/virtualcard_bloc.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/reuseable_widget.dart';

class ReviewOrder extends StatefulWidget {
  ReviewOrder({super.key});

  @override
  State<ReviewOrder> createState() => _ReviewOrderState();
}

class _ReviewOrderState extends State<ReviewOrder>
    with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;

  late VirtualcardBloc bloc;

  @override
  void initState() {
    super.initState();
    // Initialize the SlideAnimationManager
    _animationManager = SlideAnimationManager(this);
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
    return Column(
      children: [
        SlideTransition(
          position: _animationManager.slideAnimationTop,
          child: Padding(
            padding: EdgeInsets.only(top: 52.h, left: 20.w, bottom: 17.h),
            child: SizedBox(
                height: 52.h, child: CustomAppBar(title: "Review Order")),
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
            child: Column(
              children: [
                Container(
                  height: 438.h,
                  width: 335.w,
                  decoration: BoxDecoration(
                      color: AppColor.black0,
                      borderRadius: BorderRadius.circular(32.r)),
                  child: Column(
                    children: [
                      Gap(35.h),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: SizedBox(
                          height: 28.h,
                          width: 295.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Converting",
                                style: CustomTextStyle.kTxtRegular.copyWith(
                                    color: AppColor.black60,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                NumberFormat.currency(
                                        name: converting!.currency,
                                        decimalDigits: 2)
                                    .format(double.parse(converting!.amount)),
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.black100,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 16.w),
                        child: const Divider(
                          color: AppColor.black60,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: SizedBox(
                          height: 28.h,
                          width: 295.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Receiving",
                                style: CustomTextStyle.kTxtRegular.copyWith(
                                    color: AppColor.black60,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                NumberFormat.currency(
                                        name: receiving!.currency, decimalDigits: 2)
                                    .format(double.parse(receiving!.amount)),
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.black100,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 16.w),
                        child: const Divider(
                          color: AppColor.black60,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: SizedBox(
                          height: 28.h,
                          width: 295.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Buy Rate",
                                style: CustomTextStyle.kTxtRegular.copyWith(
                                    color: AppColor.black60,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "1 USD ~ 1,590",
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.black100,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 16.w),
                        child: const Divider(
                          color: AppColor.black60,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: SizedBox(
                          height: 28.h,
                          width: 295.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Fee",
                                style: CustomTextStyle.kTxtRegular.copyWith(
                                    color: AppColor.black60,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                NumberFormat.currency(
                                        name: receiving!.currency, decimalDigits: 2)
                                    .format(10),
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.black100,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 16.w),
                        child: const Divider(
                          color: AppColor.black60,
                        ),
                      ),
                      Gap(42.h),
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 16.w),
                        child: CustomButton(
                          onTap: () async {
                            bool response = await Get.to(()=>TransactionPin());
                            if(response){
                              showSuccessSlidingModal(context,
                                  successMessage: "Your currency conversion from ${converting!.currency} to ${receiving!.currency} has been successfully completed.");
                            }
                          },
                          buttonText: "Convert",
                          height: 58.h,
                          textColor: AppColor.black0,
                          borderRadius: 8.r,
                          buttonColor:  AppColor.primary100,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ConvertingData {
  String currency;
  String amount;

  ConvertingData({required this.currency, required this.amount});
}

ConvertingData? converting;
ConvertingData? receiving;
