import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/model/request/convertNairaRequest.dart';
import 'package:utilitypoint/model/request/createCard.dart';
import 'package:utilitypoint/utils/app_color_constant.dart';
import 'package:utilitypoint/utils/app_util.dart';
import 'package:utilitypoint/utils/reOccurringWidgets/transactionPin.dart';
import 'package:utilitypoint/utils/text_style.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../../bloc/card/virtualcard_bloc.dart';
import '../../../model/request/getUserRequest.dart';
import '../../../model/request/topUpCard.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/reuseable_widget.dart';
import 'convert.dart';

class ReviewOrder extends StatefulWidget {
  String? exchangeRate;
  String? convertionFee;
  String? cardId;
  bool? isCreateCard;
  bool? isTopUpCard;

  ReviewOrder(
      {super.key, this.exchangeRate,this.cardId, this.convertionFee,this.isTopUpCard, this.isCreateCard});

  @override
  State<ReviewOrder> createState() => _ReviewOrderState();
}

class _ReviewOrderState extends State<ReviewOrder>
    with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  bool isCreateCard = false;
  String cardCharge = "";
  String convertionCharge = "";
  late VirtualcardBloc bloc;

  @override
  void initState() {
    isCreateCard = widget.isCreateCard ?? false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isCreateCard) {
        bloc.add(GetExchangeRateEvent());
      }
    });
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

  String userPin = "";

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<VirtualcardBloc>(context);
    return BlocBuilder<VirtualcardBloc, VirtualcardState>(
      builder: (context, state) {
        if (state is VirtualcardError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if(state.errorResponse.message.toLowerCase().contains("insufficient")){
              showFailureSlidingModal(headerText: "Failed",
                  onTap: (){
                Get.back();
                  },
                  successMessage:  state.errorResponse.message,
                  context);
            }else{
              Future.delayed(Duration.zero, () {
                AppUtils.showSnack(
                    state.errorResponse.message ?? "Error occurred", context);
              });
            }
          });
          bloc.initial();
        }
        if (state is CardCreationSuccessful) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(
              context,
            );
            Navigator.pop(context, true);
            // Navigator.pop(context,true);
          });
          bloc.initial();
        }
        if (state is ExchangeRate) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            cardCharge = state.response.cardCreationFeeInCurrency;
            convertionCharge = state.response.feeRatePerCurrency;
          });
          bloc.initial();
        }
        if (state is CardTopUpSuccessful) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.back();
            Get.back();
            Get.back(result: true);
            showSuccessSlidingModal(context,
                successMessage: "Top up Successful!");
          });
          bloc.initial();
        }
        if (state is SuccessfullyBoughtDollar) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {

            if (isCreateCard) {
              List<dynamic> response = await Get.to(TransactionPin());
              if (response[0]) {
                // pin=response[1];
                bloc.add(CreateCardEvent(bloc.validation
                    .createCardRequest(cardCharge, response[1])));
              }
            }else if(widget.isTopUpCard==true){
              bloc.add(FundCardEvent(TopUpCardRequest(
                userId: loginResponse!.id,
                cardId: widget.cardId!,
                amount: double.parse(receiving!.amount),
                pin:userPin,
              )));
            } else {
              if(state.response.message.toLowerCase().contains("insufficient")){
                showFailureSlidingModal(headerText: "Failed",
                    successMessage:state.response.message,
                    context);
              }else{
                Get.back();
                Get.back();
                showSuccessSlidingModal(context,
                    successMessage: state.response.message);
              }
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
            body: appBodyDesign(getBody()),
          ),
        );
      },
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
                                "Receiving",
                                style: CustomTextStyle.kTxtRegular.copyWith(
                                    color: AppColor.black60,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                NumberFormat.currency(
                                        name: receiving!.currency,
                                        decimalDigits: 2)
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
                                "Buy Rate",
                                style: CustomTextStyle.kTxtRegular.copyWith(
                                    color: AppColor.black60,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "1 USD ~ ${widget.exchangeRate}",
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
                                        name: receiving!.currency,
                                        decimalDigits: 2)
                                    .format(double.parse(receiving!.amount) *
                                        double.parse(currencyConversionRateFees!
                                            .feeRatePerCurrency)),
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
                      Gap(42.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: CustomButton(
                          onTap: () async {
                            List<dynamic> response =
                                await Get.to(() => TransactionPin());
                            if (response[0]) {
                              userPin=response[1];
                              bloc.validation.setPin(response[1]);
                              bloc.add(
                                  BuyDollarEvent(ConvertNairaToDollarRequest(
                                userId: loginResponse!.id,
                                amountInDollar: receiving!.amount,
                                pin: response[1],
                                totalChargeFee:
                                    (double.parse(receiving!.amount) *
                                            double.parse(currencyConversionRateFees!.feeRatePerCurrency))
                                        .toString(),
                              )));
                            }
                          },
                          buttonText: "Convert",
                          height: 58.h,
                          textColor: AppColor.black0,
                          borderRadius: 8.r,
                          buttonColor: AppColor.primary100,
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
