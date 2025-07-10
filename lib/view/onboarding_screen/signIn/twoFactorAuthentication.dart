import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:utilitypoint/bloc/card/virtualcard_bloc.dart';
import 'package:utilitypoint/model/request/twoFactorAuthenticationRequest.dart';
import 'package:utilitypoint/model/request/verifyEmailRequest.dart';
import 'package:utilitypoint/view/bottomNav.dart';

import '../../../bloc/onboarding_new/onBoardingValidator.dart';
import '../../../bloc/onboarding_new/onboard_new_bloc.dart';
import '../../../services/api_service.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/height.dart';
import '../../../utils/mySharedPreference.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import 'login_screen.dart';

class Twofactorauthentication extends StatefulWidget {
  const Twofactorauthentication({super.key});

  @override
  State<Twofactorauthentication> createState() =>
      _TwofactorauthenticationState();
}

class _TwofactorauthenticationState extends State<Twofactorauthentication>
    with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  TextEditingController twoFactorController = TextEditingController();
  late OnboardNewBloc bloc;
  FocusNode _pinCodeFocusNode = FocusNode();
  bool activateKeyboard = false;
  String requiredNumber = "";
  late Timer _timer;
  int _start = 120;
  bool isLoading = false;
  bool isWrongOTP = false;
  bool isCompleteOTP = false;

  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    String formattedMinutes = minutes.toString();
    String formattedSeconds = seconds.toString().padLeft(2, '0');
    return "$formattedMinutes:$formattedSeconds";
  }

  StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    startTimer();
    super.initState();
    // Initialize the SlideAnimationManager
    _animationManager = SlideAnimationManager(this);
  }

  @override
  void dispose() {
    // Dispose the animation manager to avoid memory leaks
    _animationManager.dispose();
    errorController!.close();

    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<OnboardNewBloc>(context);
    return BlocBuilder<OnboardNewBloc, OnboardNewState>(
      builder: (context, state) {
        if (state is OnBoardingError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, () {
              AppUtils.showSnack(
                  state.errorResponse.message ?? "Error occurred", context);
            });
          });
          bloc.initial();
        }
        if (state is TwoFactorAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, () {
              userId = state.response.id;
              accessToken = state.response.token;
              loginResponse = state.response;
              // MySharedPreference.saveUserLoginResponse(
              //     json.encode(loginResponse));
              Get.offAll(MyBottomNav(), predicate: (route) => false);
            });
          });
          bloc.initial();
        }

        if (state is TwoFactorAuthenticationCodeResent) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppUtils.showInfoSnack(state.response.message, context);

              setState(() {
                _start = 120;
              });
              startTimer();

          });
          bloc.initial();
        }

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: OverlayLoaderWithAppIcon(
            isLoading: state is OnboardingIsLoading,
            overlayBackgroundColor: AppColor.black40,
            circularProgressColor: AppColor.primary100,
            appIconSize: 60.h,
            appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
            child: Scaffold(
              body: appBodyDesign(getBody(),context: context),
            ),
          ),
        );
      },
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SlideTransition(
            position: _animationManager.slideAnimationTop,
            child: Padding(
              padding: EdgeInsets.only(top: 52.h, left: 20.w, bottom: 17.h),
              child: SizedBox(
                  height: 52.h,
                  child: CustomAppBar(title: "Two Factor Authentication")),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _animationManager.slideAnimation,
            child: Container(
              height: 668.72.h,
              padding: EdgeInsets.symmetric(vertical: 36.h, horizontal: 24.w),
              decoration: BoxDecoration(
                color: AppColor.primary20,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 44.h,
                    width: 327.w,
                    child: Text(
                      "Enter the 4-digit code we just sent to your email address",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                        color: AppColor.black100,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  height63,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 53.h),
                    child: pinCodeTextField(context: context),
                  ),
                  Visibility(
                    visible: isWrongOTP,
                    child: Text(
                      "Wrong code, please try again",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                        color: AppColor.Error100,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Gap(44.h),
                  CustomButton(
                    onTap: () => _logIn(),
                    buttonText: "Log In",
                    textfontSize: 16.sp,
                    borderRadius: 8.r,
                    textColor: AppColor.black0,
                    height: 58.h,
                    buttonColor: isCompleteOTP
                        ? AppColor.primary100
                        : AppColor.primary40,
                  ),
                  height16,
                  Text(
                    "Didn't get code?",
                    style: CustomTextStyle.kTxtMedium.copyWith(
                      color: AppColor.black100,
                      fontSize: 14.sp,
                    ),
                  ),
                  height16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        timerText,
                        textAlign: TextAlign.end,
                        style: CustomTextStyle.kTxtBold.copyWith(
                            fontSize: 14.sp,
                            color: AppColor.secondary100,
                            fontWeight: FontWeight.w400),
                      ),
                      Gap(10.w),
                      InkWell(
                        onTap: () {
                          if (_start <= 60) {
                            bloc.add(ResendTwoFactorAuthenticatorEvent(
                                VerifiedEmailRequest(userId: userId)));
                          }
                        },
                        child: Text(
                          "Resend",
                          style: CustomTextStyle.kTxtMedium.copyWith(
                              fontWeight: _start <= 60
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              fontSize: 14.sp,
                              color: _start <= 60
                                  ? AppColor.primary100
                                  : AppColor.primary40),
                          textAlign: TextAlign.center,
                        ),
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

  Widget pinCodeTextField({required BuildContext context}) {
    return StreamBuilder<String>(
        stream: bloc.validation.otpValue,
        builder: (context, snapshot) {
          return PinCodeTextField(
            controller: twoFactorController,
            focusNode: _pinCodeFocusNode,
            onTap: () {
              setState(() {
                activateKeyboard = true;
              });
              _pinCodeFocusNode.requestFocus();
            },
            appContext: context,
            enableActiveFill: true,
            autoFocus: true,
            length: 4,
            showCursor: false,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textStyle: CustomTextStyle.kTxtMedium.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.black100),
            obscureText: false,
            keyboardType:
                activateKeyboard ? TextInputType.number : TextInputType.none,
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
                activeColor:
                    isWrongOTP ? AppColor.Error100 : AppColor.primary80,
                selectedColor:
                    isWrongOTP ? AppColor.Error100 : AppColor.primary100,
                errorBorderColor: AppColor.Error100),
            animationDuration: const Duration(milliseconds: 300),
            onChanged: (value) {
              setState(() {
                requiredNumber = value;
              });
              if (requiredNumber.length == 4) {
                // setState(() {
                //   isWrongOTP=false;
                // });
                setState(() {
                  isCompleteOTP = true;
                });
              }
              bloc.validation.twoFactorController.text =
                  twoFactorController.text;
            },
          );
        });
  }

  _logIn() {
    bloc.add(LoginUserTwoFactorAuthenticationEvent(
        bloc.validation.twoFactorAuthenticationRequest()));
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
