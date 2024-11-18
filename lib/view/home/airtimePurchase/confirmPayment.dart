import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/bloc/product/product_bloc.dart';
import 'package:utilitypoint/model/request/buyAirtimeData.dart';
import 'package:utilitypoint/utils/reOccurringWidgets/transactionPin.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../../model/response/dataPlanResponse.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';

class AirtimeRecharge {
  String networkId;
  String number;
  String productPlanCategoryId;
  String networkName;
  String networkIcon;
  String amount;
  String? productPlanId;
  String? cableName;
  String? subPlan;
  int? index;

  AirtimeRecharge({
    required this.networkId,
    required this.number,
    required this.productPlanCategoryId,
    required this.networkName,
    required this.networkIcon,
    required this.amount,
    this.cableName,
    this.subPlan,
    this.productPlanId,
    this.index,
  }
      );
}

class AirtimeConfirmPayment extends StatefulWidget {
  AirtimeRecharge airtimeRecharge;
  List<ProductPlanItemResponse> productPlanList;

  AirtimeConfirmPayment(
      {super.key,
      required this.airtimeRecharge,
      required this.productPlanList});

  @override
  State<AirtimeConfirmPayment> createState() => _AirtimeConfirmPaymentState();
}

class _AirtimeConfirmPaymentState extends State<AirtimeConfirmPayment>
    with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  bool isCreateCard = false;
  late ProductBloc bloc;
  double amountToPay =0;

  @override
  void initState() {
    if (widget.productPlanList.isEmpty) {
      widget.productPlanList.add(ProductPlanItemResponse(
          productPlanId: "",
          amount: widget.airtimeRecharge.amount,
          sellingPrice: int.parse(widget.airtimeRecharge.amount),
          productPlanName: "",
          dataSizeInMb: "",
          validityInDays: "",
          automationId: ""));
    }
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
    bloc = BlocProvider.of<ProductBloc>(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, () {
              AppUtils.showSnack(
                  state.errorResponse.message ?? "Error occurred", context);
            });
          });
          bloc.initial();
        }
        //
        if (state is AirtimeBought) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.back();
              showSuccessSlidingModal(context,
                  successMessage:state.response.data[0].message);

          });
          bloc.initial();
        }

        return OverlayLoaderWithAppIcon(
          isLoading: state is ProductIsLoading,
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
                height: 52.h, child: CustomAppBar(title: "Confirm Payment")),
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
                  height: 508.h,
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
                                "Network",
                                style: CustomTextStyle.kTxtRegular.copyWith(
                                    color: AppColor.black60,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/image/icons/${widget.airtimeRecharge.networkIcon}.png",
                                    fit: BoxFit.contain,
                                  ),
                                  Gap(8.w),
                                  Text(
                                    widget.airtimeRecharge.networkName,
                                    style: CustomTextStyle.kTxtBold.copyWith(
                                        color: AppColor.black100,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
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
                                "Mobile Number",
                                style: CustomTextStyle.kTxtRegular.copyWith(
                                    color: AppColor.black60,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                widget.airtimeRecharge.number,
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
                                "Amount",
                                style: CustomTextStyle.kTxtRegular.copyWith(
                                    color: AppColor.black60,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                NumberFormat.currency(
                                        symbol: '\₦', decimalDigits: 0)
                                    .format(double.parse(
                                        widget.airtimeRecharge.amount)),
                                style: GoogleFonts.inter(
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
                                "Cashback",
                                style: CustomTextStyle.kTxtRegular.copyWith(
                                    color: AppColor.black60,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                NumberFormat.currency(
                                        symbol: '\₦', decimalDigits: 2)
                                    .format(double.parse(
                                            widget.productPlanList[0].amount) -
                                        widget.productPlanList[0].sellingPrice
                                            .toDouble()),
                                style: GoogleFonts.inter(
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
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.black100,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                NumberFormat.currency(
                                    symbol: '\₦', decimalDigits: 1)
                                    .format(
                                  widget.productPlanList.isEmpty?
                                      double.parse(widget.airtimeRecharge.amount):
                                    widget.productPlanList[0].sellingPrice
                                        .toDouble()),
                                style: GoogleFonts.inter(
                                    color: AppColor.black100,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(42.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: CustomButton(
                          onTap: () async {
                            List<dynamic> response = await Get.to(TransactionPin());
                            if(response[0]){
                              bloc.add(BuyAirtimeEvent(
                                  BuyAirtimeDataRequest(
                                      networkId:widget.airtimeRecharge.networkId,
                                      userId: loginResponse!.id,
                                      phoneNumber:widget.airtimeRecharge.number,
                                      productPlanCategoryId: widget.airtimeRecharge.productPlanCategoryId,
                                      pin: response[1],
                                      amount: widget.productPlanList.isEmpty?widget.airtimeRecharge.amount:
                                      widget.productPlanList[0].sellingPrice.toString()
                                      , walletCategory:"naira_wallet",
                                      validatephonenetwork: 0
                                  )));
                            }
                          },
                          buttonText: "Confirm Payment",
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
