import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/model/request/signInResetPasswordRequest.dart';
import 'package:utilitypoint/utils/reOccurringWidgets/transactionPin.dart';

import '../../../bloc/onboarding_new/onboard_new_bloc.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/customValidator.dart';
import '../../../utils/image_paths.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import 'login_screen.dart';

class ResetPasswordSignIn extends StatefulWidget {
  const ResetPasswordSignIn({super.key});

  @override
  State<ResetPasswordSignIn> createState() => _ResetPasswordSignInState();
}

class _ResetPasswordSignInState extends State<ResetPasswordSignIn> with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;


  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPass = TextEditingController();
  bool isNewPasswordVisible =true;
  bool isConfirmNewPasswordVisible =true;
  String? errorNewPassword ;
  String? errorConfirmNewPassword ;

  CustomValidator customValidator = CustomValidator();
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
  late OnboardNewBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<OnboardNewBloc>(context);
    return BlocBuilder<OnboardNewBloc, OnboardNewState>(
      builder: (context, state) {
        if (state is OnBoardingError){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, (){
              AppUtils.showSnack("${state.errorResponse.message} ", context);
            });
          });
          bloc.initial();
        }
        if (state is NewPasswordCreated){
          WidgetsBinding.instance.addPostFrameCallback((_) {
          showNewPasswordSuccessfulSlidingModal(context,
          headerText: "Well Done",
          successMessage: "You have successfully reset your Password.");
          });
          bloc.initial();
        }
        return OverlayLoaderWithAppIcon(
            isLoading:state is OnboardingIsLoading,
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
                  child: CustomAppBar(title: "Reset Password")),
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
                  Text("Enter your new password. Must be different from the previous one.",
                    style: CustomTextStyle.kTxtMedium.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp),
                  ),
                  Gap(38.h),
                  SizedBox(
                    height: 88.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Enter New Password",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        Gap(2.h),
                        SizedBox(
                            height:58.h,
                            child: CustomizedTextField(
                                onChanged: (value){
                                  setState(() {
                                    errorNewPassword= customValidator.validatePassword(value);
                                  });

                                },
                                error: errorNewPassword,
                                obsec: isNewPasswordVisible,
                                surffixWidget: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      isNewPasswordVisible= !isNewPasswordVisible;
                                    });
                                  },
                                  child:Padding(
                                    padding:  EdgeInsets.only(right: 16.w),
                                    child: isNewPasswordVisible? Image.asset(
                                      ic_eye_open,
                                      height: 24.h,
                                      width: 24.h,
                                    ):Image.asset(
                                      ic_eye_close,
                                      height: 24.h,
                                      width: 24.h,
                                    ),
                                  ),
                                ),
                                isPasswordVisible: true,
                                textEditingController: newPassword,
                                isProfile: false)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 88.h,
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Confirm New Password",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        Gap(2.h),
                        SizedBox(
                            height:58.h,
                            child: CustomizedTextField(
                                onChanged: (value){
                                  setState(() {
                                    errorConfirmNewPassword= customValidator.validatePassword(value);
                                  });

                                },
                                error: errorConfirmNewPassword,
                                obsec: isConfirmNewPasswordVisible,
                                surffixWidget: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      isConfirmNewPasswordVisible= !isConfirmNewPasswordVisible;
                                    });
                                  },
                                  child:Padding(
                                    padding:  EdgeInsets.only(right: 16.w),
                                    child: isConfirmNewPasswordVisible? Image.asset(
                                      ic_eye_open,
                                      height: 24.h,
                                      width: 24.h,
                                    ):Image.asset(
                                      ic_eye_close,
                                      height: 24.h,
                                      width: 24.h,
                                    ),
                                  ),
                                ),
                                textEditingController: confirmNewPass,
                                isProfile: false)),
                      ],
                    ),
                  ),

                  Gap(24.h),
                  CustomButton(
                    onTap: (){
                      _ResetPasswordCTA();
                    },
                    buttonText: "Reset Password",
                    textColor: AppColor.black0,
                    buttonColor: AppColor.primary100,
                    borderRadius: 8.r, height: 58.h,textfontSize:16.sp,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _ResetPasswordCTA() async {
    String newPass=newPassword.text.trim();
    String confirmNew = confirmNewPass.text.trim();
    if(newPass.isEmpty||confirmNew.isEmpty){
      AppUtils.showInfoSnack("No Field should be empty", context);
    }else if(newPass.contains(confirmNew)){
      // List<dynamic> response = await Get.to(TransactionPin());
      // if(response[0]==true){
      //   print("trans");
        bloc.add(SignInCreateNewPasswordEvent(SignInResetPasswordRequest(
                    userId: loginResponse!.id,
                    password: newPass, confirmPassword: confirmNew,
                    resetCode: resetPasswordOTP)
            )
        );
      // }

    }else{
      AppUtils.showSnack("Confirm new password does not match with your new password",
        context,);
    }
  }
}
