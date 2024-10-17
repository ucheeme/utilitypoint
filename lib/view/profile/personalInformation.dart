import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/bloc/onboarding_new/onboard_new_bloc.dart';
import 'package:utilitypoint/bloc/profile/profile_bloc.dart';
import 'package:utilitypoint/model/request/updateUserRequest.dart';
import 'package:utilitypoint/view/home/home_screen.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../utils/app_color_constant.dart';
import '../../utils/app_util.dart';
import '../../utils/customAnimation.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/text_style.dart';

class PersonInformation extends StatefulWidget {
  const PersonInformation({super.key});

  @override
  State<PersonInformation> createState() => _PersonInformationState();
}

class _PersonInformationState extends State<PersonInformation> with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  bool isLightMode=false;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  late ProfileBloc bloc;
  List<String> profileTitle =["Personal Information", "Reset Password", "Reset Pin", "Default Theme"];
  @override
  void initState() {
    if(userDetails!=null){
      firstName.text=  userDetails!.firstName??"No Name";
      lastName.text= userDetails!.lastName??"No Name";
      middleName.text=  userDetails!.otherNames??"No Name";
      userName.text= userDetails!.userName??"No Name";
      emailAddress.text=userDetails!.email??"No Name";
      phoneNumber.text= userDetails!.phoneNumber??"No Name";
    }

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

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProfileBloc>(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
  builder: (context, state) {
    if (state is ProfileError){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, (){
          AppUtils.showSnack("${state.errorResponse.message}", context);
        });
      });
      bloc.initial();
    }
    if (state is UserDetailUpdate){
      WidgetsBinding.instance.addPostFrameCallback((_) {
      userDetails!.firstName = state.response.firstName;
      userDetails!.lastName = state.response.lastName;
      userDetails!.otherNames =middleName.text;
      userDetails!.userName = state.response.userName;
      userDetails!.email = state.response.email;
      userDetails!.phoneNumber = phoneNumber.text;
      showSuccessSlidingModal(
          context,
          headerText: "Detail Updated!",
          successMessage:"User Update was successful!");
      });
      Get.back();
      bloc.initial();
    }
    return OverlayLoaderWithAppIcon(
        isLoading:state is ProfileIsLoading,
        overlayBackgroundColor: AppColor.black40,
        circularProgressColor: AppColor.primary100,
        appIconSize: 60.h,
        appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
        child: Scaffold(body: appBodyDesign(getBody())));
  },
);
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SlideTransition(
            position: _animationManager.slideAnimationTop,
            child: Padding(
              padding: EdgeInsets.only(top: 52.h, left: 20.w, bottom: 17.h),
              child: SizedBox(
                  height: 52.h,
                  child: CustomAppBar(title: "Personal Information")),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _animationManager.slideAnimation,
            child: Container(
                height: 668.72.h,
                width: Get.width,
                padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 24.w),
                decoration: BoxDecoration(
                  color: AppColor.primary20,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r)),
                ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                          height: 80.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.black0,width: 1.5.w)
                          ),
                          child: Image.asset("assets/image/images_png/tempImage.png")
                      ),
                      Positioned(
                        left: 50.w,
                          bottom: -1.h,
                          child: Container(
                            height: 24.h,
                            width: 24.w,
                            padding: EdgeInsets.all(5.h),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.primary100,
                                border: Border.all(color: AppColor.primary100,width: 1.5.w)
                            ),
                             child: Image.asset("assets/image/icons/fi_camera.png")
                          )
                      )
                    ],
                  ),
                  Gap(32.h),
                  SizedBox(
                    height: 88.h,
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 88.h,
                          width: 157.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("First Name",
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.black100,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp),
                              ),
                              Gap(2.h),
                              SizedBox(
                                  height:58.h,
                                  child: CustomizedTextField(
                                    readOnly: true,
                                    textEditingController: firstName,
                                      isProfile: true)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 88.h,
                          width: 157.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Last Name",
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.black100,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp),
                              ),
                              Gap(2.h),
                              SizedBox(
                                  height:58.h,
                                  child: CustomizedTextField(
                                      readOnly: true,
                                    textEditingController: lastName,
                                      isProfile: true)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(14.h),
                  SizedBox(
                    height: 88.h,
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 88.h,
                          width: 157.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Middle Name",
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.black100,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp),
                              ),
                              Gap(2.h),
                              SizedBox(
                                  height:58.h,
                                  child: CustomizedTextField(
                                      readOnly: true,
                                    textEditingController: middleName,
                                      isProfile: true)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 88.h,
                          width: 157.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("User Name",
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.black100,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp),
                              ),
                              Gap(2.h),
                              SizedBox(
                                  height:58.h,
                                  child: CustomizedTextField(
                                      readOnly: true,
                                    textEditingController: userName,
                                      isProfile: true)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(14.h),
                  SizedBox(
                    height: 88.h,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email Address",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        Gap(2.h),
                        SizedBox(
                            height:58.h,
                            child: CustomizedTextField(
                                readOnly: true,
                                textEditingController: emailAddress,
                                isProfile: true)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 88.h,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Phone Number",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        Gap(2.h),
                        SizedBox(
                            height:58.h,
                            child:CustomizedTextField(
                              textEditingController: phoneNumber,
                              prefixWidget:CountryCodePicker(
                                initialSelection: "NG",
                                dialogSize: Size(100.w, 229.h),
                              ) ,
                              keyboardType: TextInputType.phone,
                              hintTxt: "+234 000 000 00",
                            )),
                      ],
                    ),
                  ),
                  Gap(24.h),
            CustomButton(
              onTap: (){
                if(checkIfFieldsAreFilled()){
                  bloc.add(UpdateUserDetailsEvent(UpdateUserDetailRequest(
                      userId: loginResponse!.id,
                      firstName: firstName.text.trim(),
                      lastName: lastName.text.trim(),
                      otherNames: middleName.text.trim(),
                      userName: userName.text.trim(),
                      phoneNumber: phoneNumber.text.trim())));
                }else{
                  null;
                }
              },
              buttonText: "Save Changes",
              textColor: AppColor.black0,
              buttonColor: checkIfFieldsAreFilled()?AppColor.primary100:AppColor.primary40,
              borderRadius: 8.r, height: 58.h,textfontSize:16.sp,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  bool checkIfFieldsAreFilled(){
    if(firstName.text.isEmpty||lastName.text.isEmpty||middleName.text.isEmpty||userName.text.isEmpty
    ||emailAddress.text.isEmpty||phoneNumber.text.isEmpty){
      return false;
    }else{
      return true;
    }
  }
}
