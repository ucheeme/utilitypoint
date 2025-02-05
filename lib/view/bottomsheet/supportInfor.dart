import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app_color_constant.dart';

class SupportBottomSheet extends StatefulWidget {
  final String title;
  final String body;
  const SupportBottomSheet({required this.title, required this.body,super.key});

  @override
  State<SupportBottomSheet> createState() => _SupportBottomSheetState();
}

class _SupportBottomSheetState extends State<SupportBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height:376.h,width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 19.w,vertical: 19.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH(12.h),
          Icon(Icons.info,size: 56,),
          const Spacer(),
          ctmTxtCrtB(widget.title,22.sp),
          gapH(12.h),
          Linkify(
            onOpen: (link) async {
              if (!await launchUrl(Uri.parse(link.url))) {
                throw Exception('Could not launch ${link.url}');
              }
            },
            text: widget.body,
            style: TextStyle(
                color:  AppColor.black100,
                fontSize: 14.sp,
                fontFamily: 'actionSansRegular',
                fontWeight: FontWeight.normal,
                letterSpacing: -0.25.sp
            ),
            linkStyle: const TextStyle(color: Colors.blue),
            maxLines: 5,
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: ctaBtn(title: "Send mail", tap: (){
                  Navigator.pop(context,1);
                }),
              ),
              gapW(10.0),
              Expanded(
                child: ctaOutlineBtn(title: "Call us", tap: (){
                  Navigator.pop(context,2);
                }),
              ),
            ],
          ),
          gapH(12.h),
        ],),
    );
  }
}
SizedBox gapH(height) => SizedBox(height: height,);
SizedBox gapW(width) => SizedBox(width: width,);

Future<dynamic> openBottomSheet22(BuildContext context,Widget bottomScreen,{background=AppColor.black0}) {
  return showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      backgroundColor:background,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(24.r),topLeft: Radius.circular(24.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child:  bottomScreen,
      )
  );
}

Text ctmTxtCrtB(title,
    size,
    {weight = FontWeight.normal,maxLines = 1, textAlign = TextAlign.start,color = AppColor.black100}) {
  return Text(title,
    style:
    TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'creatoDisplayBold',
        fontWeight: weight,
        letterSpacing: -0.35.sp
    ),
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: textAlign,
  );
}

GestureDetector ctaBtn({required String title,required Function()tap}) {
  return GestureDetector(onTap: tap,
    child: Container(
      width: double.infinity,height: 43.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: AppColor.primary100,
      ),
      child: Center(child: ctmTxtAct(title,AppColor.black0,14.sp),),
    ),
  );
}

Text ctmTxtAct(title,
    color,size,
    {weight = FontWeight.normal,maxLines = 1, textAlign = TextAlign.start}) {
  return Text(title,
    style:
    TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'actionSansRegular',
        fontWeight: weight,
        letterSpacing: -0.25.sp
    ),
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: textAlign,
  );
}

GestureDetector ctaOutlineBtn({required String title,required Function()tap}) {
  return GestureDetector(onTap: tap,
    child: Container(
      width: double.infinity,height: 43.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
            color: AppColor.primary100,
            width: 1.r
        ),
        color: AppColor.black0,
      ),
      child: Center(child: ctmTxtAct(title,AppColor.primary10,14.sp),),
    ),
  );
}