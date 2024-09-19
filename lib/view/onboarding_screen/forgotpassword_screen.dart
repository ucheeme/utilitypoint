import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../bloc/onboarding/bloc.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/app_util.dart';
import '../../utils/customAnimation.dart';
import '../../utils/height.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/text_style.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen>  with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  late OnBoardingBlocBloc bloc;
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
                                showSlidingModal(context);
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

