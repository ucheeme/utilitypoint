import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:utilitypoint/utils/mySharedPreference.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../bloc/onboarding_new/onboard_new_bloc.dart';
import '../app_color_constant.dart';
import '../app_util.dart';
import '../custom_keypad.dart';
import '../height.dart';
import '../reuseableFunctions.dart';
import '../reuseable_widget.dart';
import '../text_style.dart';

class TransactionPin extends StatefulWidget {
 bool? isTransactionScreen;
 String? header;
  TransactionPin({super.key, this.isTransactionScreen,this.header});

  @override
  State<TransactionPin> createState() => _TransactionPinState();
}

class _TransactionPinState extends State<TransactionPin>with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _slideControllerTop;
  // TextEditingController pinValueController=TextEditingController();
  // TextEditingController ttController=TextEditingController();
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slideAnimationTop;
  TextEditingController transactionPinController = TextEditingController();
  late OnboardNewBloc bloc;
  final LocalAuthentication _localAuth = LocalAuthentication();
  var userName=TextEditingController();
  var userPassword =TextEditingController();
  bool _isAuthenticated = false;
  String pin="";

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      if(widget.isTransactionScreen==null || widget.isTransactionScreen==false){

        print("This is first entry 0$pin");
        if(useBiometeric){

        _isAuthenticated =await  authenticate(_localAuth);
        setState(() {
          _isAuthenticated=_isAuthenticated;
        });
        if(_isAuthenticated){
          bloc.add(GetSingleUserDetailEvent(loginResponse?.id??""));
           //pin =  MySharedPreference.getStringValue("transactionPin");

          // if(pin.isEmpty){
          //   print("This is empty $pin");
          //   bloc.add(GetSingleUserDetailEvent(loginResponse?.id??""));
          // }else{
          //   print("This is empty3 $pin");
          //   Get.back(result:  [true,pin]);
          // }

        }
        }else{
         // AppUtils.showSuccessSnack("enable biometric", context);
        }
      }
    });

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
    bloc = BlocProvider.of<OnboardNewBloc>(context);
    return BlocBuilder<OnboardNewBloc, OnboardNewState>(
      builder: (context, state) {
        if(state is SingleUserDetailsState){
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            pin= state.response.pin;
            print("This is the pin $pin");
            MySharedPreference.saveAnyStringValue(key:"transactionPin", value:pin);
            Get.back(result:  [true,pin]);
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
            body: appBodyDesign(getBody(),context: context),
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
                  child: widget.header==null?CustomAppBar(title:widget.isTransactionScreen==true? "Set transaction Pin":"Enter Pin")
              :  CustomAppBar(title:widget.header!)
              ),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              height:MediaQuery.of(context).size.height,
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
                    height45,
                    StreamBuilder<Object>(
                        stream: bloc.validation.otpValue,
                        builder: (context, snapshot) {
                          return CustomButton(onTap: () {
                            bloc.validation.transactionPinController.text=transactionPinController.text;
                            MySharedPreference.saveAnyStringValue(key:"transactionPin", value:transactionPinController.text);
                            Get.back(result: [true,transactionPinController.text]);
                            bloc.validation.setOtpValue("");

                          }, buttonText: "Submit", textfontSize: 16.sp,
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
            cursorColor: Colors.transparent,
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
              onChanged:bloc.validation.setOtpValue
          );
        }
    );
  }
  _setTransactionPin(){
    //bloc.add(SetTransactionEvent(bloc.validation.setTransactionPinRequest()));
  }
}

