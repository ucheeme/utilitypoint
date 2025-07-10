
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:utilitypoint/utils/app_color_constant.dart';
import 'package:utilitypoint/utils/image_paths.dart';
import 'package:utilitypoint/utils/reuseable_widget.dart';
import 'package:utilitypoint/utils/text_style.dart';
import 'package:utilitypoint/view/menuOption/settings.dart';

import '../view/menuOption/settingOptions/verifyIdentity.dart';

class NoticeBottomSheet extends StatefulWidget {
  final String title;
  final String body;
  double? size = 376.h;
  String? image;
  Function()? onTap;
  NoticeBottomSheet({required this.title,this.onTap, required this.body,this.image,super.key, this.size,});




  @override
  State<NoticeBottomSheet> createState() => _NoticeBottomSheetState();
}

class _NoticeBottomSheetState extends State<NoticeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height:widget.size ?? 376.h,
      width: MediaQuery.of(context).size.width,
      color: AppColor.primary20,
      padding: EdgeInsets.symmetric(horizontal: 19.w,vertical: 19.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(12.h),
          Image.asset(widget.image??closeImage,width: 56.h,height: 56.h,),
          const Spacer(),
          Text(widget.title,style:CustomTextStyle.kTxtMedium.copyWith(
            color: AppColor.primary100,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600
          )
          ),
          Gap(12.h),
          Text(widget.body,
              style:CustomTextStyle.kTxtMedium.copyWith(
                  color: AppColor.black100,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400
              )
             ,maxLines: 5),
          const Spacer(),
          CustomButton(buttonText: "Proceed",
            height: 58.h,
            buttonColor: AppColor.primary100,
            onTap:widget.onTap?? (){
            Navigator.pop(context,1);
              Get.to(UserIdentityVerification());
          },textColor: AppColor.black0,borderRadius: 8.r, ),
         Gap(12.h),
        ],),
    );
  }
}
