import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/bloc/onboarding_new/onBoardingValidator.dart';
import 'package:utilitypoint/model/request/getProduct.dart';
import 'package:utilitypoint/model/request/markAsReadUnread/markReadUnRead.dart';
import 'package:utilitypoint/model/response/allUserNotification.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/utils/reOccurringWidgets/transactionPin.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';
import 'package:utilitypoint/view/onboarding_screen/signUp/personal_information.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../main.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/app_util.dart';
import '../../utils/customAnimation.dart';
import '../../utils/reuseableFunctions.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/text_style.dart';
import '../profile/personalInformation.dart';
import '../profile/resetPin.dart';
import '../profile/reset_password.dart';
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>  with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  int? selectedNot;
  late ProfileBloc bloc;
  DateTime currentDateTime = DateTime.now();
  AllUserNotification? userNotification;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      bloc.add(GetAllUserNotificationEvent(GetProductRequest(
        userId: loginResponse!.id,
          startDate: "${currentDateTime.year}-${currentDateTime.month}-01",
          endDate:"${currentDateTime.year}-${currentDateTime.month}-${_getLastDayOfTheMonth()}",
      )));
    });
    super.initState();
    // Initialize the SlideAnimationManager
    _animationManager = SlideAnimationManager(this);
  }
  int _getLastDayOfTheMonth(){
    DateTime firstDayOfNextMonth = (currentDateTime.month < 12)
        ? DateTime(currentDateTime.year, currentDateTime.month + 1, 1)
        : DateTime(currentDateTime.year + 1, 1, 1);

    // Subtract one day to get the last day of the current month
    DateTime lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
    return lastDayOfCurrentMonth.day;
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
        if (state is UserNotifications){
          WidgetsBinding.instance.addPostFrameCallback((_) {
          userNotification = state.response;
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
                  child: CustomAppBar(title: "Notifications")),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _animationManager.slideAnimation,
            child: Container(
              height: 668.72.h,
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColor.primary20,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r)),
              ),
              child: userNotification==null?
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/image/images_png/empty.png",
                    height: 40.h,
                    width: 60.w,
                  ),
                  Text(
                    "Nothing here, yet ...",
                    style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 49.h,
                    width: 269.w,
                    child: Text(
                      textAlign: TextAlign.center,
                      "No Notification yet check back later!",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.black80,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),),
                  )
                ],
              ):
              SizedBox(
                height: 600.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...userNotification!.data.mapIndexed((element, index)=>
                      GestureDetector(
                          onTap: (){
                            bloc.add(MarkNotificationAsReadEvent(MarkAsReadUnReadRequest(
                                userId: loginResponse!.id,
                              userNotificationId: element.id,
                            )));
                            setState(() {
                              selectedNot=index;
                            });
                          },
                          child: Padding(
                            padding:  EdgeInsets.only(bottom: 16.h),
                            child: SizedBox(
                                height: 120.h,
                                child: NotificationsDesign(notificationList: element, changeColor:selectedNot==index,)),
                          ))
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}

class NotificationsDesign extends StatelessWidget {
  NotificationList notificationList;
  bool changeColor;
   NotificationsDesign({super.key,required this.notificationList, required this.changeColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:  Container(
        height: 120.h,
        width: 335.w,
        padding: EdgeInsets.all(9.h),
        decoration: BoxDecoration(
          color:(notificationList.readStatus==0)?AppColor.primary30: AppColor.black0,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 5)),
          ],
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 48.h,
              width: 235.w,
              child: Row(
                children: [
                  imageContainer(notificationList.title,imagePath:notificationList.imagePath),
                  Gap(10.w),
                  SizedBox(
                    height: 44.h,
                    width: 158.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notificationList.title,
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400
                          ),),
                        Text(dateTimeFormatter(notificationList.createdAt.toIso8601String()),
                          style: CustomTextStyle.kTxtMedium.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: AppColor.black80
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(12.h),
            SizedBox(
              height: 36.w,
              child: Text(
                notificationList.content,
                style:CustomTextStyle.kTxtMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color:AppColor.black100
                ),
              ),
            )
          ],
        )
      ),
    );
  }
  Widget imageContainer(String stitle,{String? imagePath}){
    return imagePath!=null?Image.network(imagePath):
    Image.asset(images(stitle));
  }
  String images(String title){
    switch(title){
      case "new updates available!": return "assets/image/icons/adminNotification_Icon.png";
      case "account setup successful!": return "assets/image/icons/profileNotification_Icon.png";
      case "security updates": return "assets/image/icons/securityAlert_Icon.png";
      case "card": return "assets/image/icons/cardNotification_Icon.png";
      default: return"assets/image/icons/adminNotification_Icon.png";
    }
  }
}

class EmptyInfo extends StatelessWidget {
  String? body;
   EmptyInfo({super.key,  this.body,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/image/images_png/empty.png",
            height: 40.h,
            width: 60.w,
          ),
          Text(
            "Nothing here, yet ...",
            style: CustomTextStyle.kTxtBold.copyWith(
                color: AppColor.black100,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp),
          ),
          SizedBox(
            height: 49.h,
            width: 269.w,
            child: Text(
              textAlign: TextAlign.center,
              body??"No Notification yet check back later!",
              style: CustomTextStyle.kTxtMedium.copyWith(
                  color: AppColor.black80,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp),),
          )
        ],
      ),
    );
  }
}
