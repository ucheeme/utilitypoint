import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/main.dart';
import 'package:utilitypoint/utils/app_util.dart';
import 'package:utilitypoint/utils/pages.dart';

import '../../../bloc/onboarding_new/onBoardingValidator.dart';
import '../../../bloc/onboarding_new/onboard_new_bloc.dart';
import '../../../services/api_service.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/height.dart';
import '../../../utils/mySharedPreference.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import '../signIn/login_screen.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation>  with TickerProviderStateMixin {
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
  @override
  void initState() {
    MySharedPreference.saveCreateAccountStep(key: isCreateAccountSecondStep,value: false);
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

    if (state is UserInfoUpdatedState){
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        loginResponse =state.response;
        loginResponse?.email =state.response.email;
        loginResponse?.firstName =state.response.firstName;
        loginResponse?.lastName =state.response.lastName;
        loginResponse?.userName =state.response.userName;
        loginResponse?.id =state.response.id;
        loginResponse?.dollarWallet =state.response.dollarWallet;
        loginResponse?.nairaWallet =state.response.nairaWallet;
        loginResponse?.token = state.response.token;
        accessToken =state.response.token;
        userId = state.response.id;
        MySharedPreference.saveCreateAccountStep(key: isCreateAccountFourthStep,value: true);
        MySharedPreference.saveUserLoginResponse(jsonEncode(loginResponse));
        Get.toNamed(Pages.transactionPin);
      });
      bloc.initial();
    }

    if (state is OnBoardingError){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, (){
        // Get.toNamed(Pages.personalInformation);
          AppUtils.showSnack(state.errorResponse.message ?? "Error occurred", context);
        });
      });
      bloc.initial();
    }
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
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
                  child: CustomAppBar(title: "Personal Information")),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("First Name", style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp
                    ),),
                    height8,
                    StreamBuilder<Object>(
                        stream: bloc.validation.firstName,
                        builder: (context, snapshot) {
                          return CustomizedTextField(
                            error: snapshot.error?.toString(),
                            keyboardType: TextInputType.name,
                            hintTxt: "Enter first name",
                            isTouched: bloc.validation.isFirstNameSelected,
                            onTap: (){
                              setState(() {
                                bloc.validation.isLastNameSelected=false;
                                bloc.validation.isUserNameSelected= false;
                                bloc.validation.isPhoneNumberSelected= false;
                                bloc.validation.isReferralCodeSelected= false;
                                bloc.validation.isFirstNameSelected=!bloc.validation.isFirstNameSelected;
                              });
                            },
                            onChanged:  bloc.validation.setFirstName,
                          );
                        }
                    ),
                    height16,
                    Text("Last Name", style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp
                    ),),
                    height8,
                    StreamBuilder<Object>(
                        stream: bloc.validation.lastName,
                        builder: (context, snapshot) {
                          return CustomizedTextField(
                            error: snapshot.error?.toString(),
                            keyboardType: TextInputType.name,
                            hintTxt: "Enter last name",
                            isTouched: bloc.validation.isLastNameSelected,
                            onTap: (){
                              setState(() {
                                bloc.validation.isFirstNameSelected=false;
                                bloc.validation.isUserNameSelected= false;
                                bloc.validation.isPhoneNumberSelected= false;
                                bloc.validation.isReferralCodeSelected= false;
                                bloc.validation.isLastNameSelected=!bloc.validation.isLastNameSelected;
                              });
                            },
                            onChanged:  bloc.validation.setLastName,
                          );
                        }
                    ),
                    height16,
                    Text("Username", style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp
                    ),),
                    height8,
                    StreamBuilder<Object>(
                        stream: bloc.validation.userName,
                        builder: (context, snapshot) {
                          return CustomizedTextField(
                            error: snapshot.error?.toString(),
                            keyboardType: TextInputType.name,
                            hintTxt: "Enter username",
                            isTouched: bloc.validation.isUserNameSelected,
                            onTap: (){
                              setState(() {
                                bloc.validation.isFirstNameSelected=false;
                                bloc.validation.isLastNameSelected= false;
                                bloc.validation.isPhoneNumberSelected= false;
                                bloc.validation.isReferralCodeSelected= false;
                                bloc.validation.isUserNameSelected=!bloc.validation.isUserNameSelected;
                              });
                            },
                            onChanged:  bloc.validation.setUserName,
                          );
                        }
                    ),
                    height16,
                    Text("Phone Number", style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp
                    ),),
                    height8,
                    StreamBuilder<Object>(
                        stream: bloc.validation.phoneNumber,
                        builder: (context, snapshot) {
                          return CustomizedTextField(
                            prefixWidget:CountryCodePicker(
                              initialSelection: "NG",
                              dialogSize: Size(100.w, 229.h),
                
                            ) ,
                            error: snapshot.error?.toString(),
                            keyboardType: TextInputType.phone,
                            hintTxt: "+234 000 000 00",
                            isTouched: bloc.validation.isPhoneNumberSelected,
                            onTap: (){
                              setState(() {
                                bloc.validation.isFirstNameSelected=false;
                                bloc.validation.isLastNameSelected= false;
                                bloc.validation.isUserNameSelected= false;
                                bloc.validation.isReferralCodeSelected= false;
                                bloc.validation.isPhoneNumberSelected=!bloc.validation.isPhoneNumberSelected;
                              });
                            },
                            onChanged:  bloc.validation.setPhoneNumber,
                          );
                        }
                    ),
                    height16,

                    Text("Referral Code (Optional)", style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp
                    ),),
                    height8,
                    StreamBuilder<Object>(
                        stream: bloc.validation.referralCode,
                        builder: (context, snapshot) {
                          return CustomizedTextField(
                            error: snapshot.error?.toString(),
                            keyboardType: TextInputType.name,
                            hintTxt: "",
                            isTouched: bloc.validation.isReferralCodeSelected,
                            onTap: (){
                              setState(() {
                                bloc.validation.isFirstNameSelected=false;
                                bloc.validation.isLastNameSelected= false;
                                bloc.validation.isUserNameSelected= false;
                                bloc.validation.isPhoneNumberSelected= false;
                                bloc.validation.isReferralCodeSelected=!bloc.validation.isReferralCodeSelected;
                              });
                            },
                            onChanged:  bloc.validation.setReferralValue,
                          );
                        }
                    ),
                    height45,
                    StreamBuilder<Object>(
                      stream: bloc.validation.completePersonalInformationFormValidation,
                      builder: (context, snapshot) {
                        return CustomButton(onTap: (){
                         if (snapshot.hasData==true && snapshot.data!=null) {
                           bloc.validation.setFirstNameTemp();
                           _createUserInfo();
                         }else{
                          AppUtils.showInfoSnackFromBottom2("Please no field should be empty", context);
                         }
                        }, buttonText: "Next",
                          textColor: AppColor.black0,
                          buttonColor: (snapshot.hasData==true && snapshot.data!=null)?
                          AppColor.primary100:AppColor.primary40,
                        borderRadius: 8.r, height: 58.h,textfontSize:16.sp,);
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
  _createUserInfo(){
    bloc.add(SetUserInfoEvent(bloc.validation.userInfo()));
  }
}
