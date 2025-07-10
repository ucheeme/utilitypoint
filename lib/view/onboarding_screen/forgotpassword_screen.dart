import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/reset_password.dart';

import '../../bloc/onboarding_new/onboard_new_bloc.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/app_util.dart';
import '../../utils/customAnimation.dart';
import '../../utils/height.dart';
import '../../utils/reOccurringWidgets/transactionPin.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/text_style.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen>  with TickerProviderStateMixin {
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
          AppUtils.showSnack("${state.errorResponse.message} ${state.errorResponse.data}", context);
        });
      });
      bloc.initial();
    }

    if (state is ForgotPasswordSuccess){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        loginResponse = state.response;
     //   showSlidingModal(context);
        _showBottomSheet2(context,state.response.emailOtp.toString()??"");
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
            position: _animationManager.slideAnimationTop,
            child: Padding(
              padding:  EdgeInsets.only(top: 52.h,left: 20.w,bottom: 17.h),
              child: SizedBox(
                  height: 52.h,
                  child: CustomAppBar(title: "Forgot password")),
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
                    SizedBox(
                      height: 44.h,
                      width: 327.w,
                      child:Text("Enter the email address associated with your account to reset your password. ",
                        style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.black100,
                          fontSize: 14.sp,
                        ),),
                    ),
                    Gap(38),
                    Text("Email Address", style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp
                    ),),
                    height8,
                    StreamBuilder<Object>(
                        stream: bloc.validation.email,
                        builder: (context, snapshot) {
                          return CustomizedTextField(
                            error: snapshot.error?.toString(),
                            keyboardType: TextInputType.emailAddress,
                            hintTxt: "Enter email",
                            isTouched: bloc.validation.isEmailSelected,
                            onTap: (){
                              setState(() {

                                bloc.validation.isLoginUserNameSelected=!bloc.validation.isLoginUserNameSelected;
                              });
                            },
                            onChanged:  bloc.validation.setEmail,
                          );
                        }
                    ),
                    height16,
                    StreamBuilder<Object>(
                        stream: bloc.validation.email,
                        builder: (context, snapshot) {
                          return CustomButton(
                            onTap: (){
                              if (snapshot.hasData==true && snapshot.data!=null) {
                               // print(snapshot.data.toString());
                             bloc.add(ForgotPasswordEvent(snapshot.data.toString().toLowerCase()));
                              }else{
                                AppUtils.showInfoSnackFromBottom2("Please no field should be empty", context);
                              }
                            },
                            buttonText: "Send",
                            textColor: AppColor.black0,
                            buttonColor: (snapshot.hasData==true && snapshot.data!=null)?
                            AppColor.primary100 :AppColor.primary40,
                            borderRadius: 8.r,
                            height: 58.h,
                            textfontSize:16.sp,);
                        }
                    )
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

void _showBottomSheet2(BuildContext context,String title,) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (context) {
      String textToCopy = "This is your otp: $title";
      bool isCopied = false;
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 200.h,
          child: Column(
            children: [
              // Text(
              //   "Please click on the copy icon first before done",
              //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      textToCopy,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {

                      Clipboard.setData(ClipboardData(text: textToCopy));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Copied to clipboard!")),
                      );
                      isCopied = true;
                    },
                  ),
                ],
              ),
              Spacer(),
              CustomButton(
                height:58.h,
                onTap: () async {
                  if(isCopied){
                    Get.back();
                    List<dynamic> response = await Get.to(TransactionPin(header:"Enter OTP",));
                    if(response[0] == true){
                      resetPasswordOTP = response[1];
                      Get.to(ResetPasswordSignIn());
                    }
                  }else{
                    AppUtils.showInfoSnack("Please copy the otp first", context);
                  }

                }, buttonText:"Done",
                textfontSize: 13.sp,
                textColor:AppColor.black0 ,
                buttonColor: AppColor.primary100,borderRadius: 8.r,),
            ],
          ),
        ),
      );
    },
  );
}
Future<void> openEmailApp() async {
  final Uri emailUri = Uri(scheme: 'mailto'); // No recipient or query parameters

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Could not open the email app';
  }
}


