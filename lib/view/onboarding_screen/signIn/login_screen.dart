
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/bloc/onboarding_new/onBoardingValidator.dart';
import 'package:utilitypoint/services/api_service.dart';
import '../../../bloc/onboarding_new/onboard_new_bloc.dart';
import '../../../model/response/userInfoUpdated.dart';
import '../../../repository/onboarding_repository.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/height.dart';
import '../../../utils/image_paths.dart';
import '../../../utils/pages.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
UserInfoUpdated? loginResponse;
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  late OnboardNewBloc bloc;
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
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
     bloc = BlocProvider.of<OnboardNewBloc>(context);
    return BlocBuilder<OnboardNewBloc, OnboardNewState>(
  builder: (context, state) {
    if (state is OnBoardingError){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, (){
          //Get.toNamed(Pages.twoFactorAuthentication);
          if(state.errorResponse.message.toLowerCase().contains("email not verified")){
           // Get.toNamed(Pages.otpVerification);
          }
          AppUtils.showSnack(state.errorResponse.message ?? "Error occurred", context);
        });
      });
      bloc.initial();
    }
    if (state is LoggedinUser){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        userId = state.response.id;
        accessToken = state.response.token;
        loginResponse = state.response;
        Get.toNamed(Pages.twoFactorAuthentication);
      });
      bloc.initial();
    }


    return OverlayLoaderWithAppIcon(
      isLoading:state is OnboardingIsLoading,
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
  getBody(){
    return SingleChildScrollView(
      child: Column(
        children: [
          SlideTransition(
            position: _animationManager.slideAnimationTop,
            child: Padding(
              padding:  EdgeInsets.only(top: 52.h,left: 20.w,bottom: 17.h),
              child: SizedBox(
                  height: 52.h,
                  child: CustomAppBar(title: "Welcome back")),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _animationManager.slideAnimation,
            child: Container(
              height: 668.72.h,
              padding: EdgeInsets.symmetric(vertical: 36.h,horizontal: 24.w),
              decoration: BoxDecoration(
                color: AppColor.primary20,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r),topRight: Radius.circular(30.r)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Username", style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp
                    ),),
                    height8,
                    StreamBuilder<Object>(
                        stream: bloc.validation.loginUserName,
                        builder: (context, snapshot) {
                          return CustomizedTextField(
                            error: snapshot.error?.toString(),
                            keyboardType: TextInputType.name,
                            hintTxt: "Enter username",
                            isTouched: bloc.validation.isLoginUserNameSelected,
                            onTap: (){
                              setState(() {

                                bloc.validation.isLoginUserNameSelected=!bloc.validation.isLoginUserNameSelected;
                              });
                            },
                            onChanged:  bloc.validation.setLoginUserName,
                          );
                        }
                    ),
                    height16,
                    Text("Password", style: CustomTextStyle.kTxtMedium.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp
                    ),),
                    height8,
                    StreamBuilder<Object>(
                      stream: bloc.validation.loginPassword,
                      builder: (context, snapshot) {
                        return CustomizedTextField(
                          error: snapshot.error?.toString(),
                          onChanged: bloc.validation.setLoginPassword,
                          hintTxt: "Enter password",
                          surffixWidget: GestureDetector(
                            onTap: (){
                              setState(() {
                                passwordVisible=!passwordVisible;
                              });
                            },
                            child:Padding(
                              padding:  EdgeInsets.only(right: 16.w),
                              child:  passwordVisible? Image.asset(
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
                          obsec:  passwordVisible,
                         isTouched: bloc.validation.isLoginPasswordSelected,
                        );
                      }
                    ),
                    height35,
                    StreamBuilder<Object>(
                        stream: bloc.validation.loginCompleteRegistrationFormValidation,
                        builder: (context, snapshot) {
                          return CustomButton(
                            onTap: (){
                            if (snapshot.hasData==true && snapshot.data!=null) {
                              bloc.add(LoginUserEvent(bloc.validation.loginUserRequest()));
                              //AppUtils.showInfoSnackFromBottom2("Please no field should be empty", context);
                            }
                          },
                            buttonText: "Log In",
                            textColor: AppColor.black0,
                            buttonColor: (snapshot.hasData==true && snapshot.data!=null)?
                            AppColor.primary100 :AppColor.primary40,
                            borderRadius: 8.r,
                            height: 58.h,
                            textfontSize:16.sp,);
                        }
                    ),
                    height10,
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 24.w),
                      child: CustomButton(
                        height:58.h,
                        onTap: (){
                          Get.toNamed(Pages.forgotPassword);
                        }, buttonText:"Forgot Password?",
                        textColor:AppColor.primary100 ,
                        buttonColor: Colors.transparent,borderRadius: 8.r,),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
