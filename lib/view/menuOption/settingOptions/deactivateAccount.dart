import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/utils/text_style.dart';
import 'package:utilitypoint/view/home/home_screen.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../../bloc/profile/profile_bloc.dart';
import '../../../model/request/userAlertRequest.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/mySharedPreference.dart';
import '../../../utils/reOccurringWidgets/transactionPin.dart';
import '../../../utils/reuseable_widget.dart';

class DeactivateAcctScreen extends StatefulWidget {
  const DeactivateAcctScreen({super.key});

  @override
  State<DeactivateAcctScreen> createState() => _DeactivateAcctScreenState();
}

class _DeactivateAcctScreenState extends State<DeactivateAcctScreen>  with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;

  late ProfileBloc bloc;
  bool isActivateAcct = true;

  List<bool> toogleState = [
    userDetails!.emailNotification=="1"?true:false,
    userDetails!.pushNotification=="1"?true:false,
    userDetails!.smsAlert=="1"?true:false,];
  @override
  void initState() {
    if(userDetails!.accountDeactivation =="1"){
      isActivateAcct = false;
    }else{
      isActivateAcct= true;
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

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProfileBloc>(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileError){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, (){
              AppUtils.showSnack("${state.errorResponse.data}", context);
            });
          });
          bloc.initial();
        }
        if (state is UserAppSettingUpdated){
          WidgetsBinding.instance.addPostFrameCallback((_) {
           showSuccessSlidingModal(context,successMessage: "You account has been successfully ${isActivateAcct?"deactivated":"activated"}",
           onTap: (){
             Get.back();
             Get.offAll(SignInPage(), predicate: (route) => false);
           }
           );
          });
          bloc.initial();
        }
        return OverlayLoaderWithAppIcon(
            isLoading:state is ProfileIsLoading,
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
                  child: CustomAppBar(title: "Deactivate account")),
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
                  Text(
                    'Are you sure you want to deactivate your account?',
                    style: CustomTextStyle.kTxtMedium.copyWith(
                        fontSize: 18.h,
                        color: AppColor.black100,
                        fontWeight: FontWeight.w800
                    ),
                  ),
                  Gap(15.h),
                  SizedBox(
                    height: 285.h,
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'If you choose to deactivate your account:',
                         style: CustomTextStyle.kTxtRegular.copyWith(
                        fontSize: 14.h,
                        color: AppColor.black80,
                        fontWeight: FontWeight.w500
                    ),
                        ),
                     // Spacing between title and bullet points
                        BulletPoint(text: 'Your profile and content will no longer be visible to others.'),
                        BulletPoint(text: 'Information not stored in your account will remain unaffected.'),
                        BulletPoint(
                          text: 'We\'ll securely retain your data, allowing you to recover it if you decide to reactivate.',
                        ),
                        BulletPoint(
                          text: 'You can reactivate your account and restore all your content at any time using your existing login details.',
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  CustomButton(onTap:  () async {
                  // bool answer = await showSlidingModalDeactivateAccount(context);
                  // if(answer){
                     List<dynamic> response =
                     await Get.to(() => TransactionPin());
                     if (response[0]) {
                       if(userDetails?.pin == response[1]){
                         bloc.add(UpdateUserAppSettingEvent(
                             UserAlertNotificationRequest(
                               userId: loginResponse!.id,
                               emailNotification:userDetails!.emailNotification,
                               pushNotification: userDetails!.emailNotification,
                               smsAlert: userDetails!.smsAlert,
                               accountDeactivation:isActivateAcct?"1":"0" ,
                             )));
                       }
                     }
                  // }
                  },
                    height: 58.h,
                    buttonText:isActivateAcct? "Deactivate Account":"Activate Account",
                    textColor: AppColor.black0,
                    borderRadius: 8.r,
                    buttonColor: AppColor.primary100,
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
class BulletPoint extends StatelessWidget {
  final String text;

  BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\u2022',
            style: CustomTextStyle.kTxtRegular.copyWith(
              fontSize: 14.h,
              color: AppColor.black80,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(width: 8.w), // Space between bullet point and text
          Expanded(
            child: Text(
              text,
              style: CustomTextStyle.kTxtRegular.copyWith(
                  fontSize: 14.h,
                  color: AppColor.black80,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DeactivateaccountQ extends StatelessWidget {
  DeactivateaccountQ({super.key});
  late ProfileBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc= BlocProvider.of<ProfileBloc>(context);
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
            MySharedPreference.deleteAllSharedPref();
            Get.offAll(SignInPage(), predicate: (route) => false);
          });
          bloc.initial();
        }
        return Scaffold(
          backgroundColor: Colors.transparent,
          body:Animate(
            effects: [SlideEffect()],
            child: Container(
              margin: EdgeInsets.only(top: Get.height/2,left: 12.w,right: 12.w),
              height: 262.h,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: AppColor.black0
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(24.h),
                  Text(
                    "Account Deactivation",
                    style: CustomTextStyle.kTxtBold.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black100
                    ),
                  ),
                  Gap(15.h),
                  Text(
                    "Are you sure you want to deactivate your account?",
                    style: CustomTextStyle.kTxtMedium.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black100
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "You will be unable to access it again until you contact support",
                    style: CustomTextStyle.kTxtMedium.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black100
                    ),
                  ),
                  Gap(22.h),
                  CustomButton(
                    height: 58.h,
                    onTap: (){
                      // isLogOut = true.obs;
                      Get.back(result: true);
                      Get.back(result: true);
                    },
                    width: 222.w,
                    buttonText: "Deactivate my account",
                    buttonColor: AppColor.primary100,
                    textColor: AppColor.black0,
                    borderRadius: 8.r,
                  ),
                  TextButton(onPressed: (){
                    Get.back(result: false);
                  },
                      child: Text(
                        "Cancel",
                        style: CustomTextStyle.kTxtMedium.copyWith(
                            color: AppColor.secondary100,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400
                        ),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
showSlidingModalDeactivateAccount(BuildContext context,) {
  showDialog(
    context: context,
    // Makes the background transparent
    builder: (BuildContext context) {
      return DeactivateaccountQ();
    },
  );
}