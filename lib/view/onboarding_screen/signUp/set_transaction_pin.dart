import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:utilitypoint/utils/height.dart';

import '../../../bloc/onboarding/bloc.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/custom_keypad.dart';
import '../../../utils/pages.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';

class SetTransactionPin extends StatefulWidget {
  const SetTransactionPin({super.key});

  @override
  State<SetTransactionPin> createState() => _SetTransactionPinState();
}

class _SetTransactionPinState extends State<SetTransactionPin> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _slideControllerTop;
  TextEditingController pinValueController=TextEditingController();
  TextEditingController ttController=TextEditingController();
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slideAnimationTop;

  late OnBoardingBlocBloc bloc;
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
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


  bool isLoading = false;
  bool isWrongOTP = false;
  bool isCompleteOTP=false;


  @override
  void dispose() {
    _slideControllerTop.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<OnBoardingBlocBloc>(context);
    return Scaffold(
      body: appBodyDesign(getBody()),
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
                  child: CustomAppBar(title: "Set transaction Pin")),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                   Gap(30.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                        height: 30.h,
                        child: pinCodeTextField(context: context)),
                    Gap(42.h),
                    CustomKeypad(controller: pinValueController),
                    height55,
                    StreamBuilder<Object>(
                      stream: bloc.validation.otpValue,
                      builder: (context, snapshot) {
                        return CustomButton(onTap: (){  Get.toNamed(Pages.accountCreated);}, buttonText: "Finish", textfontSize: 16.sp,
                          borderRadius: 8.r,
                          textColor: AppColor.black0,height:58.h,
                          buttonColor: (snapshot.hasData==true && snapshot.data!=null)?AppColor.primary100:AppColor.primary40,);
                      }
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
  Widget pinCodeTextField({required BuildContext context}){
    return StreamBuilder<String>(
        stream: bloc.validation.otpValue,
        builder: (context, snapshot) {
          return PinCodeTextField(
            appContext: context,
            enableActiveFill: true,
            autoFocus: true,
            length: 4,
            obscuringCharacter: '●',
            obscuringWidget: Container(height: 20.h,width: 40.w,
                decoration:BoxDecoration(
                    color: AppColor.primary100,shape: BoxShape.circle)),
            animationType: AnimationType.slide,
            controller: pinValueController,
            keyboardType: TextInputType.none,
            textStyle: CustomTextStyle.kTxtMedium.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700,color: AppColor.primary100),
            obscureText: true,
            animationDuration: const Duration(microseconds: 300),
            errorAnimationController: errorController,
            pinTheme: PinTheme(
                inactiveFillColor: AppColor.black0,
                activeFillColor: AppColor.primary20,
                selectedFillColor: AppColor.primary20,
                fieldOuterPadding: EdgeInsets.zero,
                shape: PinCodeFieldShape.circle,
                fieldHeight: 20.h,
                fieldWidth: 40.w,
                inactiveColor: AppColor.black100,
                activeColor:isWrongOTP?AppColor.Error100:AppColor.primary80,
                selectedColor:isWrongOTP?AppColor.Error100:AppColor.primary100,
                errorBorderColor: AppColor.Error100
            ),
            onChanged: bloc.validation.setOtpValue
          );
        }
    );
  }

}
