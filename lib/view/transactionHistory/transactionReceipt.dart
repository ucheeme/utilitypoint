// import 'package:contacts_service/contacts_service.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:screenshot/screenshot.dart';
import 'package:utilitypoint/model/response/buy_electricity_response.dart';
import 'package:utilitypoint/utils/height.dart';
import 'package:utilitypoint/view/home/home_screen.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../model/request/confirmElectricityMeterOrCableName.dart';
import '../../../model/response/dataPlanResponse.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/reOccurringWidgets/transactionPin.dart';
import '../../../utils/reuseableFunctions.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import '../../utils/constant.dart';
import '../bottomNav.dart';

class TransactionReceiptScreen extends StatefulWidget {
  UserTransactions? userTransactions;

  TransactionReceiptScreen({super.key, this.userTransactions});

  @override
  State<TransactionReceiptScreen> createState() =>
      _TransactionReceiptScreenState();
}

class _TransactionReceiptScreenState extends State<TransactionReceiptScreen>
    with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;

  TextEditingController meterType = TextEditingController();
  TextEditingController meterNumber = TextEditingController();
  TextEditingController meterName = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool isLoadingContact = false;
  late ProductBloc bloc;

  @override
  void initState() {
    print(widget.userTransactions!.userScreenMessage);
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

  ScreenshotController screenshotController = ScreenshotController();
  String userPin = "";

  Future<void> captureAndSaveScreenshot(context) async {
    // Request permissions for Android
    if (Platform.isAndroid) {
      await [Permission.storage].request();
    }

    try {
      // Capture the screenshot as a Uint8List
      final imageBytes = await screenshotController.capture();
      if (imageBytes != null) {
        // Save the image to the gallery using image_gallery_saver
        final SaveResult result = await SaverGallery.saveImage(
          Uint8List.fromList(imageBytes),
          quality: 80,
          fileName: "screenshot",
          skipIfExists: false,
        );

        if (result.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Screenshot saved to gallery!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save screenshot.')),
          );
        }
      }
    } catch (e) {
      print('Error capturing screenshot: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save screenshot.')),
      );
    }
  }

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
        // if (state is ElectricityBought) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     Get.back();
        //     Get.back();
        //     showSuccessSlidingModal(context,
        //         successMessage:state.response.message);
        //
        //   });
        //   bloc.initial();
        // }

        return OverlayLoaderWithAppIcon(
          isLoading: state is ProductIsLoading,
          overlayBackgroundColor: AppColor.black40,
          circularProgressColor: AppColor.primary100,
          appIconSize: 60.h,
          appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
          child: Scaffold(
            body: appBodyDesign(getBody(context)),
          ),
        );
      },
    );
  }

  getBody(context) {
    return Column(
      children: [
        SlideTransition(
          position: _animationManager.slideAnimationTop,
          child: Padding(
            padding: EdgeInsets.only(top: 52.h, left: 20.w, bottom: 17.h),
            child: SizedBox(
                height: 52.h,
                child: CustomAppBar(title: "Transaction Receipt")),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(16.h),
                Center(
                    child: Image.asset(
                  "assets/image/icons/transactionReceipt_Icon.png",
                  height: 25.h,
                  width: 115.w,
                )),
                Gap(22.h),
                Text(
                  "Transaction Details",
                  style: CustomTextStyle.kTxtMedium.copyWith(
                      color: AppColor.primary100,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp),
                ),
                Gap(12.h),
                Divider(
                  color: AppColor.black40,
                ),
                height12,
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: SizedBox(
                    height: 28.h,
                    // width: 295.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 114.w,
                          child: Text(
                            "Date and Time:",
                            style: CustomTextStyle.kTxtBold.copyWith(
                                color: AppColor.primary100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Gap(12.w),
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            DateTime.now().format("d-M-yy g:i A"),
                            style: CustomTextStyle.kTxtMedium.copyWith(
                                color: AppColor.black100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: SizedBox(
                    height: 35.h,
                    // width: 295.w,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 114.w,
                          child: Text(
                            "Amount:",
                            style: CustomTextStyle.kTxtBold.copyWith(
                                color: AppColor.primary100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Gap(12.w),
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            NumberFormat.currency(
                                    symbol: (widget.userTransactions!
                                                    .walletCategory ==
                                                "naira_wallet" ||
                                            widget.userTransactions!.description
                                                .toLowerCase()
                                                .contains("from naira wallet"))
                                        ? '\₦'
                                        : '\$',
                                    decimalDigits: 0)
                                .format(amountGotten()),
                            style: GoogleFonts.inter(
                                color: AppColor.black100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: SizedBox(
                    height: 28.h,
                    // width: 295.w,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 114.w,
                          child: Text(
                            "Actual Amount:",
                            style: CustomTextStyle.kTxtBold.copyWith(
                                color: AppColor.primary100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Gap(12.w),
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            NumberFormat.currency(
                                    symbol: (widget.userTransactions!
                                                    .walletCategory ==
                                                "naira_wallet" ||
                                            widget.userTransactions!.description
                                                .toLowerCase()
                                                .contains("from naira wallet"))
                                        ? '\₦'
                                        : '\$',
                                    decimalDigits: 0)
                                .format(double.parse(
                                    widget.userTransactions?.amount?? "0")),
                            style: GoogleFonts.inter(
                                color: AppColor.black100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: SizedBox(
                    height: 28.h,
                    //   width: 295.w,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Transaction Type:",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.primary100,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        Gap(12.w),
                        SizedBox(
                          width: 190.w,
                          child: Text(
                            widget.userTransactions!.transactionCategory ??
                                "no category",
                            style: CustomTextStyle.kTxtMedium.copyWith(
                                color: AppColor.black100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.userTransactions?.transactionCategory
                              .toLowerCase() ==
                          "data" ||
                      widget.userTransactions?.transactionCategory
                              .toLowerCase() ==
                          "airtime",
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: SizedBox(
                      height: 28.h,
                      //   width: 295.w,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Network:",
                            style: CustomTextStyle.kTxtBold.copyWith(
                                color: AppColor.primary100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          Gap(12.w),
                          SizedBox(
                            width: 190.w,
                            child: Text(
                              "",
                              style: CustomTextStyle.kTxtMedium.copyWith(
                                  color: AppColor.black100,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: SizedBox(
                    height: 40.h,
                    // width: 295.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 114.w,
                          child: Text(
                            "Reference Number:",
                            style: CustomTextStyle.kTxtBold.copyWith(
                                color: AppColor.primary100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Gap(12.w),
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            maxLines: 2,
                            widget.userTransactions!.transactionId ?? "no id",
                            style: CustomTextStyle.kTxtMedium.copyWith(
                                color: AppColor.black100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: SizedBox(
                    height: 40.h,
                    // width: 295.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 114.w,
                          child: Text(
                            "Transaction Remark:",
                            style: CustomTextStyle.kTxtBold.copyWith(
                                color: AppColor.primary100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Gap(12.w),
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            maxLines: 2,
                            widget.userTransactions!.userScreenMessage ??
                                "No Value",
                            style: CustomTextStyle.kTxtMedium.copyWith(
                                color: AppColor.black100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: SizedBox(
                    height: 40.h,
                    // width: 295.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 114.w,
                          child: Text(
                            "Beneficiary Details:",
                            style: CustomTextStyle.kTxtBold.copyWith(
                                color: AppColor.primary100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Gap(12.w),
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            maxLines: 2,
                            widget.userTransactions!.phoneNumber ?? "no phone",
                            style: CustomTextStyle.kTxtMedium.copyWith(
                                color: AppColor.black100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(10.h),
                Divider(
                  color: AppColor.black40,
                ),
                Gap(8.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: SizedBox(
                    height: 40.h,
                    // width: 295.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 114.w,
                          child: Text(
                            "Sender Details:",
                            style: CustomTextStyle.kTxtBold.copyWith(
                                color: AppColor.primary100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Gap(12.w),
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            maxLines: 2,
                            "${userDetails!.firstName} ${userDetails!.lastName}",
                            style: CustomTextStyle.kTxtMedium.copyWith(
                                color: AppColor.black100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: SizedBox(
                    height: 40.h,
                    // width: 295.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 114.w,
                          child: Text(
                            "Account Type:",
                            style: CustomTextStyle.kTxtBold.copyWith(
                                color: AppColor.primary100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Gap(12.w),
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            maxLines: 2,
                            widget.userTransactions!.walletCategory ?? "",
                            style: CustomTextStyle.kTxtMedium.copyWith(
                                color: AppColor.black100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(20.h),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                //   child: CustomButton(
                //     onTap: () async {
                //       captureAndSaveScreenshot(context);
                //     },
                //     buttonText: "Download Receipt",
                //     height: 58.h,
                //     textColor: AppColor.black0,
                //     borderRadius: 8.r,
                //     buttonColor: AppColor.primary100,
                //   ),
                // ),
                // Gap(10.h),
                GestureDetector(
                  onTap: () {
                    Get.offAll(MyBottomNav(), predicate: (route) => false);
                  },
                  child: Center(
                    child: Text(
                      "Return to Home",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColor.primary100),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  double amountGotten() {
    if (double.parse(widget.userTransactions!.balanceAfter) >
        double.parse(widget.userTransactions!.balanceBefore)) {
      return double.parse(widget.userTransactions!.balanceAfter) -
          double.parse(widget.userTransactions!.balanceBefore);
    } else {
      return double.parse(widget.userTransactions!.balanceBefore) -
          double.parse(widget.userTransactions!.balanceAfter);
    }
  }
}
