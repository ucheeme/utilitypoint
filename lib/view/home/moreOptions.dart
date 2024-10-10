import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:utilitypoint/utils/app_color_constant.dart';
import 'package:utilitypoint/utils/text_style.dart';
import 'package:utilitypoint/view/bottomNav.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../bloc/onboarding_new/onBoardingValidator.dart';
import '../../utils/customAnimation.dart';
import '../../utils/pages.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/route.dart';

class Moreoptions extends StatefulWidget {
  const Moreoptions({super.key});

  @override
  State<Moreoptions> createState() => _MoreoptionsState();
}

class _MoreoptionsState extends State<Moreoptions>with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  OnboardingFormValidation validation =OnboardingFormValidation();
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
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor:AppColor.primary90,
     body: SizedBox(
       width: Get.width,
       height: Get.height,
       child:Stack(
         children: [

           Positioned(
             top: 1.h,
             child: SlideTransition(
               position: _animationManager.slideAnimationTop,
               child: Container(
                   height: 255.h,
                   width: Get.width,
                   decoration: const BoxDecoration(
                     gradient: LinearGradient(
                       colors: [AppColor.primary100,AppColor.primary10],
                       stops: [0.0, 1.0,],
                       begin: Alignment.topCenter,
                       end: Alignment.bottomCenter,
                     ),
                   ),
                   child: Column(
                     children: [
                       Gap(60.h),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           GestureDetector(
                             onTap: () {
                               Get.back(canPop: false);
                             },
                             child: Container(
                               margin: EdgeInsets.symmetric(horizontal: 14.w),
                               height: 40.h,
                               width: 40.w,
                               padding: EdgeInsets.only(
                                 left: 4.w,
                               ),
                               decoration: BoxDecoration(
                                   color: Colors.transparent,
                                   borderRadius: BorderRadius.circular(8.r),
                                   border: Border.all(
                                     color: AppColor.black0,
                                   )),
                               child: Icon(
                                 Icons.arrow_back_ios,
                                 color: AppColor.black0,
                                 size: 21,
                               ),
                             ),
                           ),
                           GestureDetector(
                             onTap: (){
                               Get.back();
                             },
                             child: Container(
                               height: 70.h,
                               width: 70.w,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 border: Border.all(color: AppColor.black0,width: 1.5.w)
                               ),
                               child: Image.asset("assets/image/images_png/tempImage.png")
                             ),
                           ),
                           SizedBox(
                             width: 50.w,
                           )
                         ],
                       ),
                       Gap(9.h),
                       Text("${loginResponse?.firstName} ${loginResponse?.lastName}",
                       style: CustomTextStyle.kTxtMedium.copyWith(
                         color: AppColor.black0,
                         fontWeight: FontWeight.w400,
                         fontSize: 18.sp
                       ),),
                       Gap(4.h),
                       Text("@${loginResponse?.userName}",
                         style: CustomTextStyle.kTxtMedium.copyWith(
                             color: AppColor.black0,
                             fontWeight: FontWeight.w400,
                             fontSize: 14.sp
                         ),),
                     ],
                   )
               ),
             ),
           ),
          // Gap(20.h),
           Positioned(
            bottom: 0.h,
             top: 220.h,
             child: SlideTransition(
               position: _animationManager.slideAnimationTop,
               child: Container(
                   height: 600.h,
                   width: Get.width,
                   padding: EdgeInsets.only(top: 16.h, bottom: 10.h),
                   decoration: BoxDecoration(
                       color: AppColor.primary20,
                       borderRadius: BorderRadius.only(topRight: Radius.circular(32.r),
                           topLeft: Radius.circular(32.r))
                   ),
                   child:ListView.builder(
                     padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                       itemCount:validation.moreOptionTitle.length,
                       itemBuilder: (context,index){
                         Map<String, String> item =validation.moreOptionTitle[index];
                     return Column(
                       children: [
                         GestureDetector(
                                   onTap: (){
                                     navigateToNewScreen(index);
                                   },
                                   child: listButtons(title: item["title"]!,icons:item["icon"]!)),
                       ],
                     );
                         })
               ),
             ),
           ),
         ],
       ),
     )
   );
  }
  navigateToNewScreen(int position){
    switch(position){
      case 0: return Get.toNamed(Pages.myCards);
      case 1: return Get.toNamed(Pages.myProfile);
      case 2: return Get.toNamed(Pages.transactionHistory);
      case 3: return Get.toNamed(Pages.notification);
      case 4: return Get.toNamed(Pages.contactUs);
      case 5: return Get.toNamed(Pages.settings);
    }
  }
}
