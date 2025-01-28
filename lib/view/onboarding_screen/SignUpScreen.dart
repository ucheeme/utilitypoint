import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utilitypoint/bloc/onboarding_new/onBoardingValidator.dart';
import 'package:utilitypoint/main.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/utils/height.dart';
import 'package:utilitypoint/utils/image_paths.dart';
import 'package:utilitypoint/utils/mySharedPreference.dart';
import 'package:utilitypoint/utils/reuseable_widget.dart';
import 'package:utilitypoint/utils/text_style.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';
import 'package:utilitypoint/view/onboarding_screen/signUp/verifyemail.dart';


import '../../bloc/onboarding_new/onboard_new_bloc.dart';
import '../../model/request/accountCreation.dart';
import '../../services/api_service.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/app_util.dart';
import '../../utils/globalData.dart';
import '../../utils/pages.dart';

class SignUpCreateAccountScreen extends StatefulWidget {
  const SignUpCreateAccountScreen({super.key});

  @override
  State<SignUpCreateAccountScreen> createState() => _SignUpCreateAccountScreenState();
}

class _SignUpCreateAccountScreenState extends State<SignUpCreateAccountScreen> with TickerProviderStateMixin {
  OnboardingFormValidation controller = OnboardingFormValidation();
   isValidString(String input) {
    final symbolPattern = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    final numberPattern = RegExp(r'\d');
    final uppercasePattern = RegExp(r'[A-Z]');
    bool containsSymbol = symbolPattern.hasMatch(input);
    bool containsUppercase = uppercasePattern.hasMatch(input);
    bool containsNumber = numberPattern.hasMatch(input);
    bool hasValidLength = input.length > 7;
    if(containsUppercase){
      setState(() {
        controller.isContainsOneUpperCaseChecked=true;
      });
    }else{
      setState(() {
        controller.isContainsOneUpperCaseChecked=false;
      });
    }
    if(containsSymbol){
      setState(() {
        controller.isContainsSymbolChecked=true;
      });
    }else{
      setState(() {
        controller.isContainsSymbolChecked=false;
      });
    }
    if(containsNumber){
      setState(() {
        controller.isContainsNumChecked=true;
      });
    }else{
      setState(() {
        controller.isContainsNumChecked=false;
      });
    }
    if(hasValidLength){
      setState(() {
        controller.isEightCharacterMinimumChecked=true;
      });
    }else{
      setState(() {
        controller.isEightCharacterMinimumChecked=false;
      });
    }
  }
  bool isAgreedPolicy=false;
  late AnimationController _slideController;
  late AnimationController _slideControllerTop;
  late AnimationController _scaleController;
  late AnimationController _moveController;
  late AnimationController _containerController;

  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slideAnimationTop;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _moveAnimation;
  late Animation<Size> _containerSizeAnimation;
  late OnboardNewBloc bloc;
  late TapGestureRecognizer _tapGestureRecognizer =TapGestureRecognizer();
  @override
  void initState() {
    MySharedPreference.saveCreateAccountStep(key: isCreateAccountFirstStep,value: true);
    super.initState();

    // Slide Animation
    _slideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _slideControllerTop = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _slideAnimationTop = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideControllerTop,
      curve: Curves.easeInOut,
    ));

    _slideAnimationTop = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideControllerTop,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));
    _slideController.forward();
    _slideControllerTop.forward();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = _handlePress;
  }


  bool isLoading = false;
  bool isWrongOTP = false;
  bool isCompleteOTP=false;
  CreateAccountRequest? request;
_handlePress(){
  openUrl("https://app.zennalfinance.com/vdc/terms_conditions");
}
  @override
  void dispose() {
    _slideControllerTop.dispose();
    _slideController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<OnboardNewBloc>(context);
    return BlocBuilder<OnboardNewBloc, OnboardNewState>(
  builder: (context, state) {
    if (state is AccountCreated){
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await GlobalData().setUserId(state.response.id);
        accessToken= state.response.token;
        userId=state.response.id;
        MySharedPreference.saveCreateAccountStep(key: isCreateAccountSecondStep,value: true);
        MySharedPreference.saveAccessToken(accessToken);
        MySharedPreference.saveUserId(value: state.response.id);
        Get.toNamed(Pages.otpVerification,);
      });
      bloc.initial();
    }
    if (state is OnBoardingError){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, (){
          AppUtils.showSnack("${state.errorResponse.message}: ${state.errorResponse.data}", context);
        });
      });
      bloc.initial();
    }
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: OverlayLoaderWithAppIcon(
        isLoading:state is OnboardingIsLoading,
       overlayBackgroundColor: AppColor.black40,
        circularProgressColor: AppColor.primary100,
        appIconSize: 60.h,
        appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
        child: Scaffold(
          body: appBodyDesign(getBody()),
        ),
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
            position: _slideAnimationTop,
            child: Padding(
              padding:  EdgeInsets.only(top: 52.h,left: 20.w,bottom: 17.h),
              child: SizedBox(
                  height: 52.h,
                  child: CustomAppBar(title: "Create your account")),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              height: 678.72.h,
              padding: EdgeInsets.symmetric(vertical: 36.h,horizontal: 24.w),
              decoration: BoxDecoration(
                color: AppColor.primary20,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r),topRight: Radius.circular(30.r)),
              ),
              child: SizedBox(
                height: 388.h,
                width: 327.w,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Email Address", style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.black100,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp
                      ),),
                      height8,
                      StreamBuilder<Object>(
                          stream: controller.email,
                          builder: (context, snapshot) {
                            return CustomizedTextField(
                              error: snapshot.error?.toString(),
                              keyboardType: TextInputType.emailAddress,
                              hintTxt: "Enter email address",
                              isTouched: controller.isEmailSelected,
                              onTap: (){
                                setState(() {
                                  controller.isPasswordSelected=false;
                                  controller.isConfirmPasswordSelected= false;
                                  controller.isEmailSelected=! controller.isEmailSelected;
                                });
                              },
                              onChanged: controller.setEmail,
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
                      CustomizedTextField(
                        textEditingController: controller.passwordController,
                        onChanged: (value){isValidString(value);
                        tempPassword = value;
                        },
                        hintTxt: "Enter password",
                        surffixWidget: GestureDetector(
                          onTap: (){
                            setState(() {
                              controller.isConfirmPasswordSelected= false;
                              controller.isEmailSelected=false;
                              controller.isPasswordSelected=true;
                              controller.isPasswordVisible=!controller.isPasswordVisible;
                            });
                          },
                          child:Padding(
                            padding:  EdgeInsets.only(right: 16.w),
                            child:  controller.isPasswordVisible? Image.asset(
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
                        obsec: controller.isPasswordVisible,
                        onTap: (){
                          setState(() {
                            controller.isConfirmPasswordSelected= false;
                            controller.isEmailSelected=false;
                            controller.isPasswordSelected=!controller.isPasswordSelected;
                          });
                        }, isTouched:  controller.isPasswordSelected,
                      ),
                      height16,
                      SizedBox(
                        height: 110.h,
                        width: Get.width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                              child: Row(
                                children: [
                                  MSHCheckbox(value:controller.isEightCharacterMinimumChecked,
                                      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                        checkedColor: AppColor.success100,
                                      ),
                                      style: MSHCheckboxStyle.fillScaleColor,
                                      onChanged: (value){}),
                                  Gap(8.w),
                                  Text("8 character minimum", style: CustomTextStyle.kTxtMedium.copyWith(
                                    color: AppColor.black100,
                                    fontSize: 14.sp,
                                  ),)
                                ],
                              ),
                            ),
                            height8,
                            SizedBox(
                              height: 20.h,
                              child: Row(
                                children: [
                                  MSHCheckbox(
                                      checkedColor:AppColor.success100 ,
                                      value:controller.isContainsNumChecked,
                                      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                        checkedColor: AppColor.success100,
                                      ),
                                      style: MSHCheckboxStyle.fillScaleColor,
                                      onChanged: (value){}),
                                  Gap(8.w),
                                  Text("a number", style: CustomTextStyle.kTxtMedium.copyWith(
                                    color: AppColor.black100,
                                    fontSize: 14.sp,
                                  ),)
                                ],
                              ),
                            ),
                            height8,
                            SizedBox(
                              height: 20.h,
                              child: Row(
                                children: [
                                  MSHCheckbox(value:controller.isContainsSymbolChecked,
                                      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                        checkedColor: AppColor.success100,
                                      ),
                                      style: MSHCheckboxStyle.fillScaleColor,
                                      onChanged: (value){}),
                                  Gap(8.w),
                                  Text("one symbol minimum", style: CustomTextStyle.kTxtMedium.copyWith(
                                    color: AppColor.black100,
                                    fontSize: 14.sp,
                                  ),)
                                ],
                              ),
                            ),
                            height8,
                            SizedBox(
                              height: 20.h,
                              child: Row(
                                children: [
                                  MSHCheckbox(value:controller.isContainsOneUpperCaseChecked,
                                      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                        checkedColor: AppColor.success100,
                                      ),
                                      style: MSHCheckboxStyle.fillScaleColor,
                                      onChanged: (value){}),
                                  Gap(8.w),
                                  Text("one capital letter", style: CustomTextStyle.kTxtMedium.copyWith(
                                    color: AppColor.black100,
                                    fontSize: 14.sp,
                                  ),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      height16,
                      Text("Confirm Password", style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.black100,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp
                      ),),
                      height8,
                      StreamBuilder<Object>(
                          stream: controller.confirmPassword,
                          builder: (context, snapshot) {
                            return SizedBox(
                              height: 70.h,
                              child: CustomizedTextField(
                                onEditingComplete: (){controller.validatePasswords();
                                setState(() {});
                                FocusScope.of(context).unfocus();
                                },
                                hintTxt: "Re-enter password",
                                error:(snapshot.error!=null)?snapshot.error?.toString():null,
                                onChanged:controller.setConfirmPassword,
                                readOnly: controller.passwordController.text.isEmpty,
                                surffixWidget: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      controller.isConfirmPasswordSelected= true;
                                      controller.isEmailSelected=false;
                                      controller.isPasswordSelected=false;
                                      controller.isConfirmPasswordVisible=!controller.isConfirmPasswordVisible;
                                    });
                                  },
                                  child:Padding(
                                    padding:  EdgeInsets.only(right: 16.w),
                                    child:  controller.isConfirmPasswordVisible? Image.asset(
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
                                obsec: controller.isConfirmPasswordVisible,
                                keyboardType:TextInputType.text,
                                onTap: (){
                                  setState(() {
                                    controller.isPasswordSelected= false;
                                    controller.isEmailSelected=false;
                                    controller.isConfirmPasswordSelected=!controller.isConfirmPasswordSelected;
                                  });
                                },
                                isTouched:controller.isConfirmPasswordSelected,
                              ),
                            );
                          }
                      ),
                      Visibility(
                        visible: controller.isPasswordMatch,
                        child: Text("Password matches",style: CustomTextStyle.kTxtMedium.copyWith(
                            color: AppColor.success100,fontSize: 10.sp
                        ),),
                      ),
                      height22,
                      SizedBox(
                        height: 66.h,
                        width: 326.w,
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Checkbox(value: isAgreedPolicy, onChanged: (value){
                                setState(() {
                                  isAgreedPolicy=!isAgreedPolicy;
                                });
                              },
                                activeColor: AppColor.primary100,
                              ),
                            ),
                            SizedBox(
                              height: 66.h,
                              width: 269.w,
                              child: RichText(
                                text: TextSpan(
                                    text: "I certify that I am 18 years of age or older, and I agree to the ",
                                    style: CustomTextStyle.kTxtMedium.copyWith(
                                        color: AppColor.black100,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp
                                    ),
                                    children: [
                                     TextSpan(
                                       recognizer: _tapGestureRecognizer,
                                        text: "User Agreement and Privacy Policy",
                                        style: CustomTextStyle.kTxtMedium.copyWith(
                                            color: AppColor.primary100,
                                            fontSize: 14.sp
                                        ),
                                      )
                                    ]
                                ),

                              ),
                            )
                          ],
                        ),
                      ),
                      height45,
                      StreamBuilder<Object>(
                          stream: controller.completeRegistrationFormValidation,
                          builder: (context, snapshot) {
                            return CustomButton(
                              height:58.h,
                              onTap: (){
                                (snapshot.hasData == true && snapshot.data != null)?
                                validateUserPassword(isAgreedPolicy, context):null;
                              }, buttonText: "Next",
                              textColor:AppColor.black0 ,
                              buttonColor:  (snapshot.hasData == true && snapshot.data != null)?AppColor.primary100:
                              AppColor.primary40,borderRadius: 8.r,);
                          }
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 24.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?",
                              style: CustomTextStyle.kTxtMedium.copyWith(
                                  color: AppColor.black100,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp
                              ),
                            ),
                            Gap(4.w),
                            CustomButton(
                              height:58.h,
                              onTap: (){
                                Get.to(const SignInPage());
                              }, buttonText:"SignIn",
                              textfontSize: 13.sp,
                              textColor:AppColor.primary100 ,
                              buttonColor: Colors.transparent,borderRadius: 8.r,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    // Check if the URL can be launched
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
  validateUserPassword(bool response, BuildContext context){
    if(response){
      _registerUser();
    }else{
      AppUtils.showInfoSnackFromBottom("Please accept privacy policy to proceed", context);
    }
  }
  _registerUser(){
    request =  controller.createAccountRequest();
    print(request!.email);
    print(request!.password);
    print(request!.passwordConfirmation);
    bloc.add(CreateUserAccountEvent(request!));
  }
}
