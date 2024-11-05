import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/utils/app_color_constant.dart';
import 'package:utilitypoint/utils/text_style.dart';
import 'package:utilitypoint/view/bottomNav.dart';
import 'package:utilitypoint/view/home/home_screen.dart';
import 'package:utilitypoint/view/menuOption/notifications.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../bloc/onboarding_new/onBoardingValidator.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../model/request/getProduct.dart';
import '../../model/request/logOutRequest.dart';
import '../../model/response/allUserNotification.dart';
import '../../utils/app_util.dart';
import '../../utils/customAnimation.dart';
import '../../utils/pages.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/route.dart';
import '../profile/personalInformation.dart';

class Moreoptions extends StatefulWidget {
  const Moreoptions({super.key});

  @override
  State<Moreoptions> createState() => _MoreoptionsState();
}

class _MoreoptionsState extends State<Moreoptions>
    with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  OnboardingFormValidation validation = OnboardingFormValidation();
  late ProfileBloc bloc;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(GetAllUserUploadedKYCEvent(GetProductRequest(userId: loginResponse!.id)));

   //   bloc.add(GetUserDetails(GetProductRequest(userId: loginResponse!.id)));
    });
    super.initState();
    // Initialize the SlideAnimationManager
    _animationManager = SlideAnimationManager(this);
  }
  DateTime currentDateTime = DateTime.now();
  @override
  void dispose() {
    // Dispose the animation manager to avoid memory leaks
    _animationManager.dispose();
    super.dispose();
  }
  AllUserNotification? userNotification;
  int _getLastDayOfTheMonth(){
    DateTime firstDayOfNextMonth = (currentDateTime.month < 12)
        ? DateTime(currentDateTime.year, currentDateTime.month + 1, 1)
        : DateTime(currentDateTime.year + 1, 1, 1);

    // Subtract one day to get the last day of the current month
    DateTime lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
    return lastDayOfCurrentMonth.day;
  }
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProfileBloc>(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {

        if (state is ProfileError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, () {
              AppUtils.showSnack(state.errorResponse.message, context);
            });
          });
          bloc.initial();
        }
        if (state is UserLogOut) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.offAll(SignInPage(), predicate: (route) => false);
          });
          bloc.initial();
        }

        if (state is AllUserDetails) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            userDetails = state.response;
          });
          bloc.initial();
        }

        if (state is UserKYCs) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            userDetails!.profilePic= state.response.profilePicture;
            userImage.value=state.response.profilePicture!;
          });
          bloc.initial();
        }

        return OverlayLoaderWithAppIcon(
          isLoading: state is ProfileIsLoading,
          overlayBackgroundColor: AppColor.black40,
          circularProgressColor: AppColor.primary100,
          appIconSize: 60.h,
          appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
          child: Scaffold(
              backgroundColor: AppColor.primary90,
              body: SizedBox(
                width: Get.width,
                height: Get.height,
                child: Stack(
                  children: [
                    Positioned(
                      top: 1.h,
                      child: SlideTransition(
                        position: _animationManager.slideAnimationTop,
                        child: Container(
                            height: 255.h,
                            width: Get.width,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColor.primary100,
                                  AppColor.primary10
                                ],
                                stops: [
                                  0.0,
                                  1.0,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Column(
                              children: [
                                Gap(60.h),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.back(canPop: false);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 14.w),
                                        height: 40.h,
                                        width: 40.w,
                                        padding: EdgeInsets.only(
                                          left: 4.w,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(8.r),
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
                                    Container(
                                      height: 70.h,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(image: userDetails!.profilePic==null?Image.asset(
                                              "assets/image/images_png/tempImage.png").image:
                                          Image.network(userDetails!.profilePic!,fit: BoxFit.cover,).image ),
                                          border: Border.all(
                                              color: AppColor.black0,
                                              width: 1.5.w)
                                      ),

                                    ),
                                    SizedBox(width: 50.w,)
                                  ],
                                ),
                                Gap(9.h),
                                Text(
                                  "${loginResponse?.firstName} ${loginResponse
                                      ?.lastName}",
                                  style: CustomTextStyle.kTxtMedium.copyWith(
                                      color: AppColor.black0,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.sp),
                                ),
                                Gap(4.h),
                                Text(
                                  "@${loginResponse?.userName}",
                                  style: CustomTextStyle.kTxtMedium.copyWith(
                                      color: AppColor.black0,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp),
                                ),
                              ],
                            )
                        ),
                      ),
                    ),
                    // Gap(20.h),
                    Positioned(
                      bottom: 0.h,
                      top: 220.h,
                      child: SlideTransition(
                        position: _animationManager.slideAnimationTop,
                        child: Container(
                            height: 600.h,
                            width: Get.width,
                            padding: EdgeInsets.only(top: 16.h, bottom: 10.h),
                            decoration: BoxDecoration(
                                color: AppColor.primary20,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(32.r),
                                    topLeft: Radius.circular(32.r))),
                            child: ListView.builder(
                                padding:
                                EdgeInsets.only(top: 20.h, bottom: 10.h),
                                itemCount: validation.moreOptionTitle.length,
                                itemBuilder: (context, index) {
                                  Map<String, String> item =
                                  validation.moreOptionTitle[index];
                                  return Column(
                                    children: [
                                      GestureDetector(
                                          onTap: () async {
                                            if (index == 6) {
                                              showSlidingModalLogOut(
                                                  context);

                                              if (isLogOut.value) {

                                              }
                                            } else {
                                              navigateToNewScreen(index);
                                            }
                                          },
                                          child: listButtons(
                                              isNotification: index == 3,
                                              notifications: index == 3
                                                  ? numOfNotification.toString()
                                                  : "",
                                              title: item["title"]!,
                                              icons: item["icon"]!)),
                                    ],
                                  );
                                })),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  navigateToNewScreen(int position) {
    switch (position) {
      case 0:
        return Get.toNamed(Pages.myCards);
      case 1:
        return Get.toNamed(Pages.myProfile);
      case 2:
        return Get.toNamed(Pages.transactionHistory);
      case 3:
        return Get.toNamed(Pages.notification);
      case 4:
        return Get.toNamed(Pages.contactUs);
      case 5:
        return Get.toNamed(Pages.settings);
    }
  }
}
