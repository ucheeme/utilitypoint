import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:utilitypoint/bloc/onboarding/bloc.dart';
import 'package:utilitypoint/utils/height.dart';
import 'package:utilitypoint/utils/pages.dart';
import 'package:utilitypoint/utils/text_style.dart';

import '../../../utils/app_color_constant.dart';
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
  late OnBoardingBlocBloc bloc;
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
    bloc = BlocProvider.of<OnBoardingBlocBloc>(context);
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: appBodyDesign(getBody()),
      ),
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
                borderRadius: BorderRadius.circular(30.r),
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
                  CustomButton(onTap: (){  Get.toNamed(Pages.personalInformation);}, buttonText: "Next", textfontSize: 16.sp,
                    borderRadius: 8.r,
                  textColor: AppColor.black0,height:58.h,buttonColor: isCompleteOTP?AppColor.primary100:AppColor.primary40,),
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
                          //  bloc.add(ResendOtp(bloc.validation.resendOtp()));
                          }

                        },
                        child: Text("Resend",
                          style: CustomTextStyle.kTxtMedium.copyWith(fontWeight: FontWeight.w400, fontSize: 14.sp, color: _start !=0? AppColor.primary100: AppColor.primary40 ),textAlign: TextAlign.center,),
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
            keyboardType: TextInputType.number,
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
            onChanged: (value) {
              setState(() {
                requiredNumber = value;
              });
              if(requiredNumber.length==4){
                if(value=="5555"){
                  setState(() {
                    isWrongOTP=true;
                  });
                }else{
                  setState(() {
                    isWrongOTP=false;
                  });

                }
                setState(() {
                  isCompleteOTP=true;
                });

              }
            },
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
}
