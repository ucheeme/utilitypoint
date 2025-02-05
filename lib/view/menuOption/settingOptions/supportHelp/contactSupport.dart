import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utilitypoint/utils/constant.dart';

import '../../../../bloc/profile/profile_bloc.dart';
import '../../../../utils/app_color_constant.dart';
import '../../../../utils/reuseable_widget.dart';
import '../../../../utils/text_style.dart';

class ContactsupportScreen extends StatefulWidget {
  const ContactsupportScreen({super.key});

  @override
  State<ContactsupportScreen> createState() => _ContactsupportScreenState();
}

class _ContactsupportScreenState extends State<ContactsupportScreen> {
  late ProfileBloc bloc;
  List<Map<String,String>> contactUs =[
    {"title":"07073459839",
      "subTitle":"Call our 24/7 customer support",
      "icon":"callUs_Icon"},
    {"title":"utilitypointsolution@gmail.com",
      "subTitle":"Email us for any concerns or inquiries ",
      "icon":"email_Icon"},
    {"title":"Whatsapp Us",
      "subTitle":"Start chat with our customer support",
    "icon":"whatsapp_Icon"
    }
  ];


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
          Padding(
            padding: EdgeInsets.only(top: 52.h, left: 20.w, bottom: 17.h),
            child: SizedBox(
                height: 52.h,
                child: CustomAppBar(title: "Contact Us")),
          ),
          Gap(20.h),
          Container(
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
                          cTA(index, element["title"]!);
                        },
                        child: contactUsListingDesign(title: element["title"]!,
                            subtext: element["subTitle"]!,icon: element["icon"]!
                        ))
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  cTA(int index, String title){
    switch(index){
      case 0: return callNumber(title);
      case 1: return sendEmail(emailAddress: title,);
      case 2: return openWhatsApp(title);
    }
  }
  Future<void> callNumber(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    // Check if the phone can make a call
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
  Future<void> openSocialMedia(String url) async {
    final Uri uri = Uri.parse(url);

    // Check if the URL can be launched
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> openWhatsApp(String phoneNumber, {String message = ''}) async {
    final Uri whatsappUri = Uri.parse("https://wa.me/234=7073459839?text=${Uri.encodeComponent(message)}");

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open WhatsApp';
    }
  }
  Future<void> sendEmail({
    required String emailAddress,
    String subject = '',
    String body = '',
  }) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );
    // Check if the device can send an email
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not send email to $emailAddress';
    }
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