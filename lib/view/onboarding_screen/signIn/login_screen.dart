
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:local_auth/local_auth.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utilitypoint/bloc/onboarding_new/onBoardingValidator.dart';
import 'package:utilitypoint/services/api_service.dart';
import 'package:utilitypoint/utils/mySharedPreference.dart';
import 'package:utilitypoint/view/onboarding_screen/SignUpScreen.dart';
import '../../../bloc/onboarding_new/onboard_new_bloc.dart';
import '../../../main.dart';
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
import '../../bottomsheet/supportInfor.dart';
import '../../home/home_screen.dart';
import '../../splashScreen/splashScreen.dart';
bool useBiometeric =false;
UserInfoUpdated? loginResponse;
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  late OnboardNewBloc bloc;
  final LocalAuthentication _localAuth = LocalAuthentication();
  var userName=TextEditingController();
  var userPassword =TextEditingController();
  bool _isAuthenticated = false;

  Future<void> _authenticate() async {
    try {
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      bool isAuthenticated = false;

      if (canCheckBiometrics&&userNameBio.isNotEmpty&&passwordBio.isNotEmpty) {
        isAuthenticated = await _localAuth.authenticate(
          localizedReason: 'Authenticate to access the app',
          options: AuthenticationOptions(
            biometricOnly: true,
          ),
        );
      }
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
      if(_isAuthenticated){
        // Get.back();
        bloc.add(LoginUserEvent(bloc.validation.loginUserRequestBio()));
      }

    } catch (e) {
      print("Error during authentication: $e");
    }
  }
  @override
  void initState() {
    _authenticate();
    WidgetsBinding.instance.addPostFrameCallback((_){
      setState(() {
        userName.text = userNameBio;
      });
      // if(useBiometeric){
      //   _showBottomSheet(context);
      // }
      bloc.validation.setLoginUserName(userNameBio);
    });
    super.initState();
    // Initialize the SlideAnimationManager
    _animationManager = SlideAnimationManager(this);
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: false,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding:  EdgeInsets.all(20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    // Logic for login or authentication

                    _authenticate();
                    // Navigator.of(context).pop(); // Close the BottomSheet
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.fingerprint,
                        size: 100,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Tap on me to login",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
        verificationStatus=int.parse(loginResponse!.canDoCardTransaction);
    // Get.offAllNamed(Pages.bottomNav, predicate: (route) => false);
        if(state.response.requireOtp==1){
          _showBottomSheet2(context,state.response.emailOtp.toString()??"");
          // Get.toNamed(Pages.twoFactorAuthentication);
        }else{
          // Get.toNamed(Pages.bottomNav);
          Get.offAllNamed(Pages.bottomNav, predicate: (route) => false);
        }

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
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
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
                height: Get.height,
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
                              textEditingController: userName,
                              error: snapshot.error?.toString(),
                              keyboardType: TextInputType.name,
                              hintTxt: "Enter username/email",
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
                            textEditingController:userPassword ,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StreamBuilder<Object>(
                              stream: bloc.validation.loginCompleteRegistrationFormValidation,
                              builder: (context, snapshot) {
                                return Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 13.w),
                                  child: CustomButton(
                                   // width:useBiometeric ? 250.w: 316.w,
                                    width:useBiometeric ? Get.width*0.5: Get.width*0.8,
                                    onTap: (){
                                      if (snapshot.hasData==true && snapshot.data!=null) {
                                        FirebaseAnalytics.instance.logEvent(
                                          name: 'loginButton',
                                          parameters: {'loginButton': 'clicked'},
                                        );
                                        MySharedPreference.saveAnyStringValue(key:isUserName,value:userName.text);
                                        MySharedPreference.saveAnyStringValue(key:isUserPassword,value:userPassword.text);
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
                                    textfontSize:16.sp,),
                                );
                              }
                          ),
                          Visibility(
                              visible: useBiometeric,
                              child: Gap(10.w)),
                          Visibility(
                            visible: useBiometeric,
                            child: GestureDetector(
                              onTap: (){
                                _authenticate();
                              },
                              child: Container(
                                height: 58.h,
                                width: 58.w,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color:  AppColor.primary100,
                                ),
                                child:  Icon(
                                  Icons.fingerprint,
                                  size: 50,
                                  color: AppColor.black0,
                                ),
                              ),
                            ),
                          )
                        ],
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

                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 24.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",
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
                               Get.to(SignUpCreateAccountScreen());
                              }, buttonText:"SignUp",
                              textfontSize: 13.sp,
                              textColor:AppColor.primary100 ,
                              buttonColor: Colors.transparent,borderRadius: 8.r,),



                          ],
                        ),
                      ),
                     Gap(60.h),
                      Center(
                        child: GestureDetector(onTap: (){
                          _openSupportNoticeSheet();
                        },
                          child: resetText("having issues?", " Contact Us"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  RichText resetText(text1, text2) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text1,
        style: TextStyle(
          color: AppColor.black100,
          fontSize: 12.sp,
          fontFamily: 'actionSansRegular',
          fontWeight: FontWeight.w500,
          letterSpacing: -0.25.sp,
          //decoration: TextDecoration.underline
        ),

        children: [
          TextSpan(
            text: text2,
            style: TextStyle(color: AppColor.primary100,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
            // Add onTap handler if needed
          ),
        ],
      ),);
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
                      Get.back();
                      Get.toNamed(Pages.twoFactorAuthentication);
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
  _openSupportNoticeSheet()async{
    var result= await openBottomSheet22( context, const SupportBottomSheet(title: "Contact us", body: "send us a mail:utilitypointsolution@gmail.com\ncall us: +2347073459839\nVisit us: Head Office",));
    if(result!= null){
      if(result ==1){
        if (!await launchUrl(Uri.parse("utilitypointsolution@gmail.com"))) {
          throw Exception('Could not launch ');
        }
      }
      if(result ==2){
        if (!await launchUrl(Uri.parse("tel:+2347073459839"))) {
          throw Exception('Could not launch ');
        }
      }
    }
  }
}
