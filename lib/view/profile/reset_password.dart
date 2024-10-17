import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/bloc/profile/profile_bloc.dart';
import 'package:utilitypoint/model/request/changePassword.dart';
import 'package:utilitypoint/utils/app_util.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../utils/app_color_constant.dart';
import '../../utils/customAnimation.dart';
import '../../utils/customValidator.dart';
import '../../utils/image_paths.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/text_style.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  bool isLightMode=false;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPass = TextEditingController();
  bool isOldPasswordVisible =true;
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
  late ProfileBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProfileBloc>(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
  builder: (context, state) {
    if (state is ProfileError){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, (){
          AppUtils.showSnack("${state.errorResponse.message} ", context);
        });
      });
      bloc.initial();
    }
    if (state is PasswordChangedSuccefully){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
        showSuccessSlidingModal(
            context,
            headerText: "Password Changed!",
            successMessage: "Your Password has been updated successfully!");
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
                  SizedBox(
                    height: 88.h,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Enter Old Password",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        Gap(2.h),
                        SizedBox(
                            height:63.h,
                            child: CustomizedTextField(

                                obsec:isOldPasswordVisible,
                                surffixWidget: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      isOldPasswordVisible= !isOldPasswordVisible;
                                    });
                                  },
                                  child:Padding(
                                    padding:  EdgeInsets.only(right: 16.w),
                                    child: isOldPasswordVisible? Image.asset(
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
                                isPasswordVisible: false,
                                textEditingController: oldPassword,
                                isProfile: false)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 90.h,
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
                            height:65.h,
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
                  Gap(6.h),
                  SizedBox(
                    height: 90.h,
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
                            height:65.h,
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
  _ResetPasswordCTA(){
    String newPass=newPassword.text.trim();
    String confirmNew = confirmNewPass.text.trim();
    String oldP= oldPassword.text.trim();
    if(newPass.isEmpty||oldP.isEmpty||confirmNew.isEmpty){
      AppUtils.showInfoSnack("No Field should be empty", context);
    }else if(newPass.contains(confirmNew)){

      bloc.add(
          ChangePasswordEvent(
            ChangeUserPasswordRequest(
                userId: loginResponse!.id,
                currentPassword: oldP,
                newPassword: newPass, confirmNewPassword: confirmNew)
          )
      );
    }else{
      AppUtils.showSnack("Confirm new password does not match with your new password",
          context,);
    }
  }
}
