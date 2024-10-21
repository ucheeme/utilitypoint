import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/view/home/home_screen.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../../bloc/profile/profile_bloc.dart';
import '../../../model/request/userAlertRequest.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
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


  List<bool> toogleState = [
    userDetails!.emailNotification=="1"?true:false,
    userDetails!.pushNotification=="1"?true:false,
    userDetails!.smsAlert=="1"?true:false,];
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
        if (state is ProfileError){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, (){
              AppUtils.showSnack("${state.errorResponse.data}", context);
            });
          });
          bloc.initial();
        }
        if (state is UserAppSettingUpdated){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            state.response;
          });
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
                      listButtons(title: element, hasSwitch: true,
                        onChanged: (value){

                        setState(() {
                          toogleState[index]=value;
                        });
                        if(index==0){
                          String res = value==true?"1":"0";
                          bloc.add(UpdateUserAppSettingEvent(
                              UserAlertNotificationRequest(
                                userId: loginResponse!.id,
                                emailNotification:res,
                                pushNotification: userDetails!.pushNotification,
                                smsAlert: userDetails!.smsAlert,
                                accountDeactivation: '0',
                              )));
                        }else if(index ==1){
                          String res = value==true?"1":"0";
                          bloc.add(UpdateUserAppSettingEvent(
                              UserAlertNotificationRequest(
                                userId: loginResponse!.id,
                                emailNotification:userDetails!.emailNotification,
                                pushNotification: res,
                                smsAlert: userDetails!.smsAlert,
                                accountDeactivation: '0',
                              )));
                        }else if(index == 2) {
                          String res = value==true?"1":"0";
                          bloc.add(UpdateUserAppSettingEvent(
                              UserAlertNotificationRequest(
                                userId: loginResponse!.id,
                                emailNotification:userDetails!.emailNotification,
                                pushNotification: userDetails!.emailNotification,
                                smsAlert: res,
                                accountDeactivation: '0',
                              )));
                        }

                        },switchValue: toogleState[index]
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


