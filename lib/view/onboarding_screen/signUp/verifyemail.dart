import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:utilitypoint/utils/height.dart';
import 'package:utilitypoint/utils/pages.dart';
import 'package:utilitypoint/utils/text_style.dart';

import '../../../bloc/onboarding_new/onboard_new_bloc.dart';
import '../../../model/defaultModel.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/reuseable_widget.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> with TickerProviderStateMixin {
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
  FocusNode _pinCodeFocusNode = FocusNode();
  TextEditingController otpController= TextEditingController();
  bool activateKeyboard = false;
  @override
  void initState() {

    errorController = StreamController<ErrorAnimationType>();
    startTimer();
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
  }
    StreamController<ErrorAnimationType>? errorController;
  String requiredNumber="";

  late Timer _timer;
  int _start = 60;
  bool isLoading = false;
  bool isWrongOTP = false;
  bool isCompleteOTP=false;
  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    String formattedMinutes = minutes.toString();
    String formattedSeconds = seconds.toString().padLeft(2, '0');
    return "$formattedMinutes:$formattedSeconds";
  }

  @override
  void dispose() {
    errorController!.close();
    _slideController.dispose();
    _slideControllerTop.dispose();
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<OnboardNewBloc>(context);
    return BlocBuilder<OnboardNewBloc, OnboardNewState>(
  builder: (context, state) {
    if (state is EmailVerified){
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Get.toNamed(Pages.personalInformation);
      });
      bloc.initial();
    }
    if (state is ReSentEmailVerification){
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppUtils.showInfoSnack(state.response.message, context);
      });
      bloc.initial();
    }

    if (state is OnBoardingError){
      WidgetsBinding.instance.addPostFrameCallback((_) {
          if(state.errorResponse.message=="Sorry you entered the wrong code"){
            setState(() {
                  isWrongOTP=true;});
          }else{
            AppUtils.showSnack(state.errorResponse.message ?? "Error occurred", context);
          }


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
                  child: CustomAppBar(title: "Verify your email")),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              height: 668.72.h,
              padding: EdgeInsets.symmetric(vertical: 36.h,horizontal: 24.w),
              decoration: BoxDecoration(
                color: AppColor.primary20,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r),topRight: Radius.circular(30.r)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 44.h,
                    width: 327.w,
                    child:Text("Enter the 4-digit code we just sent to your email address",
                    style: CustomTextStyle.kTxtMedium.copyWith(
                      color: AppColor.black100,
                      fontSize: 14.sp,
                    ),),
                  ),
                  height63,
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 53.h),
                    child: pinCodeTextField(context: context),
                  ),
                  Visibility(
                    visible: isWrongOTP,
                    child: Text("Wrong code, please try again", style: CustomTextStyle.kTxtMedium.copyWith(
                      color: AppColor.Error100,fontSize: 14.sp,
                    ),),
                  ),
                  height63,
                  CustomButton(
                    onTap: (){_verifyEmail();},
                    buttonText: "Next",
                    textfontSize: 16.sp,
                    borderRadius: 8.r,
                    textColor: AppColor.black0,
                    height:58.h,
                    buttonColor: isCompleteOTP?AppColor.primary100:AppColor.primary40,),
                  height16,
                  Text("Didn't get code?", style: CustomTextStyle.kTxtBold.copyWith(
                    color: AppColor.black100,fontSize: 14.sp,
                  ),),
                  height16,
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(timerText,textAlign: TextAlign.end, style:CustomTextStyle.kTxtBold.copyWith(fontSize: 14.sp, color:AppColor.secondary100, fontWeight: FontWeight.w400 ),),
                      Gap(10.w),
                      InkWell(
                        onTap:(){
                          if(_start ==0){
                            setState(() {_start=60;});
                            startTimer();
                            _resendVerificationCodeEmail();
                          }

                        },
                        child: Text("Resend",
                          style: CustomTextStyle.kTxtMedium.copyWith(
                              fontWeight: _start ==0?FontWeight.bold:FontWeight.w400,
                              fontSize: 14.sp,
                              color: _start ==0? AppColor.primary100: AppColor.primary40 ),textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
      
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget pinCodeTextField({required BuildContext context}){
    return StreamBuilder<String>(
        stream: bloc.validation.otpValue,
        builder: (context, snapshot) {
          return PinCodeTextField(
            controller: otpController,
            focusNode: _pinCodeFocusNode,
            onTap: (){
              setState(() {
                activateKeyboard=true;
              });
              _pinCodeFocusNode.requestFocus();
            },
            appContext: context,
            enableActiveFill: true,
            autoFocus: true,
            length: 4,
            showCursor: false,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            textStyle: CustomTextStyle.kTxtMedium.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700,color: AppColor.black100),
            obscureText: false,
            keyboardType: activateKeyboard?TextInputType.number:TextInputType.none,
            animationType: AnimationType.fade,
            errorAnimationController: errorController,
            pinTheme: PinTheme(
              inactiveFillColor: AppColor.black0,
              activeFillColor: AppColor.primary20,
              selectedFillColor: AppColor.primary20,
              fieldOuterPadding: EdgeInsets.zero,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(6.r),
                fieldHeight: 51.h,
                fieldWidth: 40.w,
                inactiveColor: AppColor.black100,
                activeColor:isWrongOTP?AppColor.Error100:AppColor.primary80,
                selectedColor:isWrongOTP?AppColor.Error100:AppColor.primary100,
              errorBorderColor: AppColor.Error100
            ),
            animationDuration: const Duration(milliseconds: 300),
            onChanged:(value){
              setState(() {
                requiredNumber = value;
              });
              if(requiredNumber.length==4){
                setState(() {
                  isCompleteOTP=true;
                 bloc.validation.otpController=value;
                });
              }else{
                setState(() {
                  isWrongOTP=false;
                });
              }
            }
          );
        }
    );
  }


  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            isLoading = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  _verifyEmail(){

    bloc.add(VerifyUserEmailEvent(bloc.validation.verifiedEmailRequest()));
  }
  _resendVerificationCodeEmail(){
    bloc.add(ResendEmailVerificationCodeEvent(bloc.validation.resendVerifiedEmailRequest()));
  }
}
