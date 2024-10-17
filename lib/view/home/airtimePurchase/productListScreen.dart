import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/model/request/getProduct.dart';
import 'package:utilitypoint/view/home/home_screen.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import '../dataPurchase/singleDataPurchase.dart';
import 'buyBulkAirtime.dart';
import 'buySingleAirtime.dart';

class BuySingleAirtime extends StatefulWidget {
  BuySingleAirtime({super.key});

  @override
  State<BuySingleAirtime> createState() => _BuySingleAirtimeState();
}

class _BuySingleAirtimeState extends State<BuySingleAirtime>
    with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  bool isAirtime = true;
  bool isAirtimeBulk = false;
  bool isData = false;

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
  late ProductBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProductBloc>(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductError){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, (){
              AppUtils.showSnack(state.errorResponse.message ?? "Error occurred", context);
            });
          });
          bloc.initial();
        }

        return OverlayLoaderWithAppIcon(
            isLoading: state is ProductIsLoading,
            overlayBackgroundColor: AppColor.black40,
            circularProgressColor: AppColor.primary100,
            appIconSize: 60.h,
            appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
            child: Scaffold(body: appBodyDesign(getBody())));
      },
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SlideTransition(
            position: _animationManager.slideAnimationTop,
            child: Padding(
              padding: EdgeInsets.only(top: 52.h, left: 20.w, bottom: 17.h),
              child: SizedBox(
                  height: 52.h,
                  child: CustomAppBar(title: "Airtime & data purchase")),
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
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dashboardIcons(
                            title: "Airtime Single",
                            icon: "buyAirtime",
                            onTap: () {
                              setState(() {
                                isAirtime = true;
                                isAirtimeBulk = false;
                                isData = false;
                              });
                            },
                            isSelected: isAirtime),
                        dashboardIcons(
                            title: "Bulk Airtime",
                            icon: "bulkAirtime_Icon",
                            onTap: () {
                              setState(() {
                                isAirtime = false;
                                isAirtimeBulk = true;
                                isData = false;
                              });
                            },
                            isSelected: isAirtimeBulk),
                        dashboardIcons(
                            title: "Data",
                            icon: "data_Icon",
                            onTap: () {
                              setState(() {
                                isAirtime = false;
                                isAirtimeBulk = false;
                                isData = true;
                              });
                              // Get.to(ConvertScreen());
                            },
                            isSelected: isData),
                      ],
                    ),
                  ),
                  Gap(10.h),
                  SizedBox(
                      height: 58.h,
                      child: CustomizedTextField(isTouched: false)),
                  SizedBox(
                    height: 400.h,
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/image/images_png/empty.png",
                          height: 40.h,
                          width: 60.w,
                        ),
                        Text(
                          "Nothing here, yet ...",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 49.h,
                          width: 269.w,
                          child: Text(
                            textAlign: TextAlign.center,
                            " You have not saved any airtime or data beneficiary. Buy Airtime or Data to proceed.",
                            style: CustomTextStyle.kTxtMedium.copyWith(
                                color: AppColor.black80,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp),),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      onTap: () async {
                        if(isAirtime){
                          Get.to(SingleBuyAirtime());
                        }else if(isAirtimeBulk){
                          Get.to(BulkAirtimeScreen());
                        }else if(isData){
                          Get.to(BuySingeDataScreen());
                        }

                      },
                      buttonText: "Proceed",
                      buttonColor: AppColor.primary100,
                      textColor: AppColor.black0,
                      borderRadius: 8.r,
                      height: 58.h,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
