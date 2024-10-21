import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/utils/text_style.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/customAnimation.dart';
import '../../utils/reuseable_widget.dart';class ContactusScreen extends StatefulWidget {
  const ContactusScreen({super.key});

  @override
  State<ContactusScreen> createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen>with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();
  late ProfileBloc bloc;
  List<Map<String,String>> contactUs =[
    {"title":"07004005000",
    "subTitle":"Call our 24/7 customer support",
    "icon":"callUs_Icon"},
    {"title":"info@utilitypoint.ng",
      "subTitle":"Email us for any concerns or inquiries ",
      "icon":"email_Icon"},
    {"title":"Live Chat",
      "subTitle":"Start live chat with our customer support",
      "icon":"live_chat_Icon"},
    {"title":"Utilitypointng",
      "subTitle":"Connect with us on facebook",
      "icon":"facebook_Icon"},
    {"title":"Utilitypointng",
      "subTitle":"Connect with us on X",
      "icon":"X_Icon"},
    {"title":"Utilitypointng",
      "subTitle":"Connect with us on instagram",
      "icon":"instagram_Icon"},
  ];



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
    bloc = BlocProvider.of<ProfileBloc>(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {

        return OverlayLoaderWithAppIcon(
            isLoading:false,
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
                  child: CustomAppBar(title: "Contact Us")),
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
                  ...contactUs.mapIndexed((element,index)=>
                  GestureDetector(
                      onTap: (){

                      },
                      child: contactUsListingDesign(title: element["title"]!,
                        subtext: element["subTitle"]!,icon: element["icon"]!
                      ))
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}

Widget contactUsListingDesign({String title ="", String subtext="",String icon=""}){
  return Container(
    height:72.h,
    width: 335.w,
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    margin: EdgeInsets.symmetric(vertical: 14.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 8)),
      ],
      color: AppColor.black0,
    ),
    child: Row(
      children: [
        Image.asset("assets/image/icons/$icon.png",height: 24.h,width: 24.w,),
        Gap(12.h),
        SizedBox(
          height: 46.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
              style: CustomTextStyle.kTxtBold.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.primary100
              ),
              ),
          Text(subtext,
            style: CustomTextStyle.kTxtRegular.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 13.sp,
                color: AppColor.black80
            ),
          )
            ],
          ),
        )
      ],
    ),
  );
}