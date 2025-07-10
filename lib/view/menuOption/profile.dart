import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:utilitypoint/utils/reOccurringWidgets/transactionPin.dart';
import 'package:utilitypoint/view/onboarding_screen/signUp/personal_information.dart';

import '../../main.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/customAnimation.dart';
import '../../utils/reuseable_widget.dart';
import '../profile/personalInformation.dart';
import '../profile/resetPin.dart';
import '../profile/reset_password.dart';

class ProfileScreen extends StatefulWidget {
  bool? isBottomNav;
   ProfileScreen({super.key, this.isBottomNav});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  bool isLightMode=false;
  List<String> profileTitle =["Personal Information", "Reset Password", "Reset Pin", "Default Theme"];
  @override
  void initState() {
    if(themeMode ==ThemeMode.dark){
      isLightMode =false;
    }else{
      isLightMode =true;
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
    return Scaffold(body: appBodyDesign(getBody(),context: context));
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
                  child: CustomAppBar(title: "Profile",isBottomNav: widget.isBottomNav,)),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _animationManager.slideAnimation,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 24.w),
              decoration: BoxDecoration(
                color: AppColor.primary20,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r)),
              ),
                child:ListView.builder(
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
              itemCount:profileTitle.length,
              itemBuilder: (context,index){
                return Column(
                  children: [
                    GestureDetector(
                        onTap: (){
                          navigateToANewScree(index);
                        },
                        child: listButtons(title: profileTitle[index],hasSwitch: index==3?true:false,
                          switchValue: isLightMode, onChanged: (value){
                          setState(() {
                            isLightMode=!isLightMode;
                            if(isLightMode){
                              themeMode=ThemeMode.light;
                            }else{
                              themeMode=ThemeMode.dark;
                            }

                          });
                            }
                         )
                    ),
                  ],
                );
              })
            ),
          )
        ],
      ),
    );
  }
  navigateToANewScree(int index){
    switch(index){
      case 0: return Get.to(PersonInformation());
      case 1: return Get.to(ResetPassword());
      case 2: return Get.to(ResetTransactionPin());
     // case 0: return Get.to(PersonalInformation());
    }
  }
}
