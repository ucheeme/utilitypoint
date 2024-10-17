import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:utilitypoint/model/request/resetPin.dart';
import 'package:utilitypoint/view/home/home_screen.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/app_util.dart';
import '../../utils/custom_keypad.dart';
import '../../utils/height.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/text_style.dart';

class ConfirmTransactionPin extends StatefulWidget {
  String oldPin;
  String newPin;
   ConfirmTransactionPin({super.key,required this.oldPin, required this.newPin});

  @override
  State<ConfirmTransactionPin> createState() => _ConfirmTransactionPinState();
}

class _ConfirmTransactionPinState extends State<ConfirmTransactionPin>with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _slideControllerTop;
  // TextEditingController pinValueController=TextEditingController();
  // TextEditingController ttController=TextEditingController();
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slideAnimationTop;
  TextEditingController transactionPinController = TextEditingController();
  late ProfileBloc bloc;
  String pinValue="";
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

        if (state is PinReset){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            userDetails!.pin = pinValue;
            Get.back();
            Get.back();
            Get.back();
            showSuccessSlidingModal(
                context,
                headerText: "Detail Updated!",
                successMessage:"User Update was successful!");
          });
          bloc.initial();
        }
        return OverlayLoaderWithAppIcon(
          isLoading:state is ProfileIsLoading,
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
            position: _slideAnimationTop,
            child: Padding(
              padding:  EdgeInsets.only(top: 52.h,left: 20.w,bottom: 17.h),
              child: SizedBox(
                  height: 52.h,
                  child: CustomAppBar(title:"Confirm Transaction Pin")),
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
                    CustomKeypad(controller: transactionPinController),
                    height55,
                    CustomButton(onTap: () {
                      //Get.back(result: transactionPinController.text);
                      if(widget.newPin.contains(pinValue)){
                        bloc.add(ResetPinEvent(ResetUserPinRequest(
                            userId: loginResponse!.id,
                            currentPin: widget.oldPin,
                            newPin: widget.newPin,
                            confirmNewPin: pinValue)));
                      }else{
                        AppUtils.showSnack("Pin mismatch", context);
                      }

                    }, buttonText: "Reset Pin", textfontSize: 16.sp,
                      borderRadius: 8.r,
                      textColor: AppColor.black0,height:58.h,
                     buttonColor: (pinValue.isNotEmpty &&
                         pinValue.length==4)?AppColor.primary100:AppColor.primary40,),
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
        controller: transactionPinController,
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
        onChanged:(value){
          setState(() {
            pinValue=transactionPinController.text;
          });
        }
    );
  }
  _setTransactionPin(){
    //bloc.add(SetTransactionEvent(bloc.validation.setTransactionPinRequest()));
  }
}
