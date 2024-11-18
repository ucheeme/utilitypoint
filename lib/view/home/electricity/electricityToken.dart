
// import 'package:contacts_service/contacts_service.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:screenshot/screenshot.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../model/request/confirmElectricityMeterOrCableName.dart';
import '../../../model/response/buy_electricity_response.dart';
import '../../../model/response/dataPlanResponse.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/reOccurringWidgets/transactionPin.dart';
import '../../../utils/reuseableFunctions.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import '../../bottomNav.dart';
import '../../onboarding_screen/signIn/login_screen.dart';
import '../airtimePurchase/confirmPayment.dart';
import '../home_screen.dart';
import 'confirmMeterInfo.dart';

class ElectricTokenScreen extends StatefulWidget {
   ElectricityAdminMessage? electricityAdminMessage;
  AirtimeRecharge airtimeRecharge;
  ProductPlanItemResponse productPlanList;
  ElectricTokenScreen({super.key,
    required this.airtimeRecharge,
    required this.productPlanList,
    this.electricityAdminMessage
   });

  @override
  State<ElectricTokenScreen> createState() => _ElectricTokenScreenState();
}

class _ElectricTokenScreenState extends State<ElectricTokenScreen> with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  GlobalKey _globalKey = GlobalKey();
  TextEditingController meterType = TextEditingController();
  TextEditingController meterNumber = TextEditingController();
  TextEditingController meterName = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool isLoadingContact = false;
  late ProductBloc bloc;
  String tokenPart="";
  String unitPart="";
  String transIdPart="";
  String amountPart="";

  @override
  void initState() {
    String input = widget.electricityAdminMessage!.detail.info.realresponse;

    tokenPart = input.isNotEmpty?input.substring(0, input.indexOf("UNIT:")).trim():"";
    unitPart = input.isNotEmpty?input.substring(input.indexOf("UNIT:"), input.indexOf("TRANSID:")).trim():"";
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
  ScreenshotController screenshotController = ScreenshotController();

  // Function to capture and save the screenshot
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
          fileName: "screenshot", skipIfExists: false,
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
        //
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
                height: 52.h, child: CustomAppBar(title: "Electric Token")),
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
                  height: 593.h,
                  width: 335.w,
                  decoration: BoxDecoration(
                      color: AppColor.black0,
                      borderRadius: BorderRadius.circular(32.r)),
                  child: Column(
                    children: [
                      Gap(20.h),
                      Container(
                        height: 78.h,
                        width: 298.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColor.black60),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Electricity Token",
                            style: CustomTextStyle.kTxtMedium.copyWith(
                              color: AppColor.black60,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp
                            ),
                            ),
                            SizedBox(
                              height: 36.h,
                              width: 260.w,
                              child: Row(
                                children: [
                                  Text(formatText(tokenPart.replaceAll("TOKEN:", "").replaceAll("-", "")),
                                    style: CustomTextStyle.kTxtBold.copyWith(
                                        color: AppColor.primary100,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20.sp
                                    ),
                                  ),
                                  Gap(8.w),
                                  GestureDetector(
                                    onTap: (){
                                      copyToClipboard(
                                          context, tokenPart.replaceAll("TOKEN:", "").replaceAll("-", ""));
                                    },
                                    child: Image.asset(
                                      "assets/image/icons/fi_copy.png",
                                      height: 20.h,
                                      width: 20.w,
                                      color: AppColor.primary100,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Gap(30.h),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.h),
                        child: SizedBox(
                          height: 28.h,
                          width: 295.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date and Time:",
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.primary100,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text( DateTime.now().format("d-M-yy g:i A"),
                                style: CustomTextStyle.kTxtMedium.copyWith(
                                    color: AppColor.black100,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: SizedBox(
                          height: 28.h,
                          width: 295.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Amount:",
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.primary100,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                NumberFormat.currency(
                                    symbol: '\₦', decimalDigits: 0)
                                    .format(double.parse(widget.airtimeRecharge.amount.toString())),
                                style: GoogleFonts.inter(
                                    color: AppColor.black100,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: SizedBox(
                          height: 28.h,
                          width: 295.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Meter Number:",
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.primary100,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                widget.airtimeRecharge.number,
                                style: CustomTextStyle.kTxtMedium.copyWith(
                                    color: AppColor.black100,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: SizedBox(
                          height: 28.h,
                          width: 295.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Meter Name:",
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.primary100,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                               // widget.productPlanList.productPlanName,
                                widget.airtimeRecharge.cableName??"",
                                style: CustomTextStyle.kTxtMedium.copyWith(
                                    color: AppColor.black100,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: SizedBox(
                          height: 28.h,
                          width: 295.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Disco:",
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.primary100,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(  widget.productPlanList.productPlanName,
                                style: CustomTextStyle.kTxtMedium.copyWith(
                                    color: AppColor.black100,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: SizedBox(
                          height: 28.h,
                          width: 295.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Unit:",
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.primary100,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text("${unitPart.replaceAll("UNIT:", "")}kwH",
                                style: CustomTextStyle.kTxtMedium.copyWith(
                                    color: AppColor.black100,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20.w),
                        child: Divider(color: AppColor.black40,),
                      ),
                      Gap(20.h),
                      Container(
                        height: 78.h,
                        width: 298.w,
                        padding: EdgeInsets.only(left: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColor.black20,
                          border: Border.all(color: AppColor.black20),
                        ),
                        child: Row(
                          children: [
                           Icon(Icons.info,),
                            Gap(8.w),
                            SizedBox(
                              width: 240.w,
                              child: Text(
                                maxLines: 2,
                                "For more information, complaints or inquiries contact our call center.",
                              style: CustomTextStyle.kTxtMedium.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColor.black80
                              ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Gap(32.h),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                      //   child: CustomButton(
                      //     onTap: () async {
                      //       captureAndSaveScreenshot(context);
                      //     },
                      //     buttonText: "Download",
                      //     height: 58.h,
                      //     textColor: AppColor.black0,
                      //     borderRadius: 8.r,
                      //     buttonColor: AppColor.primary100,
                      //   ),
                      // ),
                      // Gap(10.h),
                      GestureDetector(
                        onTap: (){
                          Get.offAll(MyBottomNav(), predicate: (route) => false);
                        },
                        child: Text(
                          "Return to Home",
                          style: CustomTextStyle.kTxtMedium.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColor.primary100
                          ),
                        ),
                      ),
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
