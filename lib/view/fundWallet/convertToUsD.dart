import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../bloc/card/virtualcard_bloc.dart';
import '../../model/request/convertNairaRequest.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/app_util.dart';
import '../../utils/image_paths.dart';
import '../../utils/reOccurringWidgets/transactionPin.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/text_style.dart';
import '../menuOption/convertFunds/convert.dart';
import '../onboarding_screen/signIn/login_screen.dart';

class ConvertToUSDFund extends StatefulWidget {
  String amount;
  ScrollController controller;
  ConvertToUSDFund({super.key, required this.amount,required this.controller});

  @override
  State<ConvertToUSDFund> createState() => _ConvertToUSDFundState();
}

class _ConvertToUSDFundState extends State<ConvertToUSDFund> {
  late VirtualcardBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<VirtualcardBloc>(context);
    return  BlocBuilder<VirtualcardBloc, VirtualcardState>(
      builder: (context, state) {
        if (state is VirtualcardError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, () {
              AppUtils.showSnack(
                  state.errorResponse.message ?? "Error occurred", context);
            });
          });
          bloc.initial();
        }
        if (state is SuccessfullyBoughtDollar) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if(state.response.message.toLowerCase()=="incorrect pin entered"){
              Get.back();
              showFailureSlidingModal(context,
              headerText: "Failed",
                successMessage: state.response.message,
                onTap: () async {
                  List<dynamic> response =
                      await Get.to(() => TransactionPin());
                  if (response[0]) {
                    // userPin=response[1];
                    bloc.validation.setPin(response[1]);
                    bloc.add(
                        BuyDollarEvent(ConvertNairaToDollarRequest(
                          userId: loginResponse!.id,
                          amountInDollar:widget.amount,
                          pin: response[1],
                          totalChargeFee:
                          (double.parse(widget.amount) *
                              double.parse(currencyConversionRateFees!.feeRatePerCurrency))
                              .toString(),
                        )));
                  }
                }
              );
            }else{
              Get.back();
              Get.back();
              showSuccessSlidingModal(context,
                  successMessage: state.response.message);
            }
          });
          bloc.initial();
        }

        return OverlayLoaderWithAppIcon(
          isLoading: state is VirtualcardIsLoading,
          overlayBackgroundColor: AppColor.black40,
          circularProgressColor: AppColor.primary100,
          appIconSize: 60.h,
          appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
          child: Scaffold(
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
                  SizedBox(
                    height: 50.h,
                    width: 50.w,
                    child: Image.asset(walletIcon,),
                  ),
                  Gap(24.h),
                  Text(
                    'Convert to USD',
                    textAlign: TextAlign.center,
                    style:CustomTextStyle.kTxtBold.copyWith(color: AppColor.black100,
                        fontSize: 20.sp,fontWeight: FontWeight.w400),
                  ),
                  Gap(13.h),
                  Text(
                    'Confirm transaction details to proceed',
                    textAlign: TextAlign.center,
                    style:CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black80,
                        fontSize: 14.sp,fontWeight: FontWeight.w400),
                  ),
                  Gap(32.h),
                  Column(
                    children: [
                      Container(
                        height: 286.h,
                        width: 335.w,
                        decoration: BoxDecoration(
                            color: AppColor.black0,
                            borderRadius: BorderRadius.circular(32.r)),
                        child: Column(
                          children: [
                            Gap(25.h),
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: SizedBox(
                                height: 28.h,
                                width: 295.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "You're Exchanging",
                                      style: CustomTextStyle.kTxtRegular.copyWith(
                                          color: AppColor.black60,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      NumberFormat.currency(
                                          name: dollarSymbol,
                                          decimalDigits: 2)
                                          .format(double.parse(widget.amount)),
                                      style: CustomTextStyle.kTxtMedium.copyWith(
                                          color: AppColor.black100,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: const Divider(
                                color: AppColor.black60,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
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
                                      "1 USD ~ ${currencyConversionRateFees!.nairaRate}",
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
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                                          name: nairaSymbol,
                                          decimalDigits: 2)
                                          .format(double.parse(currencyConversionRateFees!.cardCreationFeeInCurrency) ),
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
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                                      "Total",
                                      style: CustomTextStyle.kTxtMedium.copyWith(
                                          color: AppColor.black100,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      NumberFormat.currency(
                                           symbol: "₦",
                                          locale: "en_NG",
                                          name: 'NGN',
                                          decimalDigits: 2)
                                          .format(double.parse(currencyConversionRateFees!.nairaRate)*double.parse(widget.amount) ),
                                      style: CustomTextStyle.kTxtBold.copyWith(
                                          color: AppColor.black100,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(34.h),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 14.w),
                        child: CustomButton(
                          onTap: () async {
                            List<dynamic> response =
                            await Get.to(() => TransactionPin());
                            if (response[0]) {
                             // userPin=response[1];
                              bloc.validation.setPin(response[1]);
                              bloc.add(
                                  BuyDollarEvent(ConvertNairaToDollarRequest(
                                    userId: loginResponse!.id,
                                    amountInDollar:widget.amount,
                                    pin: response[1],
                                    totalChargeFee:
                                    (double.parse(widget.amount) *
                                        double.parse(currencyConversionRateFees!.feeRatePerCurrency))
                                        .toString(),
                                  )));
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

                ],
              ),
            ) ,
          ),
        );
      },
    );
  }
}

