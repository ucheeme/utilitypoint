import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/utils/constant.dart';

import '../../../bloc/profile/profile_bloc.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/reuseable_widget.dart';

class Alertnotification extends StatefulWidget {
  const Alertnotification({super.key});

  @override
  State<Alertnotification> createState() => _AlertnotificationState();
}

class _AlertnotificationState extends State<Alertnotification>  with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;

  late ProfileBloc bloc;
  List<String> settings =[
    "Email Notification",
    "Push Notification",
    "SMS Alert",
  ];
  List<bool> toogleState = [true,false,false];
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
                  child: CustomAppBar(title: "Alert & Notification")),
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
                  ...settings.mapIndexed((element,index)=>
                      GestureDetector(
                        onTap: (){

                        },
                        child: listButtons(title: element, hasSwitch: true,
                          onChanged: (value){
                          setState(() {
                            toogleState[index]=value;
                          });
                          },switchValue: toogleState[index]
                        ),
                      )
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


