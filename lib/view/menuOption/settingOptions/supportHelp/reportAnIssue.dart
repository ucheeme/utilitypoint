import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utilitypoint/utils/app_util.dart';
import 'package:utilitypoint/utils/text_style.dart';

import '../../../../bloc/profile/profile_bloc.dart';
import '../../../../utils/app_color_constant.dart';
import '../../../../utils/height.dart';
import '../../../../utils/myCustomCamera/secondCamera.dart';
import '../../../../utils/reusable_widget_two.dart';
import '../../../../utils/reuseable_widget.dart';

class ReportanissueScreen extends StatefulWidget {
  const ReportanissueScreen({super.key});

  @override
  State<ReportanissueScreen> createState() => _ReportanissueScreenState();
}

class _ReportanissueScreenState extends State<ReportanissueScreen> {
  late ProfileBloc bloc;
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
String fileName ="";
  FilePickerResult? resultValue;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProfileBloc>(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return OverlayLoaderWithAppIcon(
            isLoading: false,
            overlayBackgroundColor: AppColor.black40,
            circularProgressColor: AppColor.primary100,
            appIconSize: 60.h,
            appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
            child: Scaffold(body: appBodyDesign(getBody(),context: context)));
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
                height: 52.h, child: CustomAppBar(title: "Report an issue")),
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 69.h,
                    child: Text(
                      "Describe the problem you have "
                      "encountered. Please be as specific as possible. "
                      "You can attach files below.",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.black100,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Gap(24.h),
                  Text(
                    "Subject",
                    style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp),
                  ),
                  height8,
                  CustomizedTextField(
                    textEditingController: subjectController,
                    keyboardType: TextInputType.name,
                    hintTxt: "Enter Report Subject Head",
                  ),
                  Gap(16.h),
                  Text(
                   "Body",
                    style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp),
                  ),
                  height8,
                  ReusableTextFormField(
                    controller: bodyController,
                    isPassword: false,
                    validator: null,
                    maxlines: 8,
                    textInputType: TextInputType.text,
                  ),
                  Gap(16.h),
                  Text(
                    "Attach File",
                    style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp),
                  ),
                  height8,
                  Row(
                    children: [
                      GestureDetector(
                        onTap: ()async{
                          pickFile();
                        },
                        child: Container(
                          height: 58.h,
                          width: 128.w,
                          decoration: BoxDecoration(
                            color: AppColor.primary20,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: AppColor.black40)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle_outline,color: AppColor.black80,),
                              Gap(10.w),
                              Text( (fileName.isNotEmpty)?"Select":"Change",
                              style: CustomTextStyle.kTxtMedium.copyWith(
                                color: AppColor.black80,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp
                              ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Gap(10.w),
                      Visibility(
                        visible: fileName.isNotEmpty,
                        child: Container(
                          height: 58.h,
                          width: 250.w,
                          decoration: BoxDecoration(
                              color: AppColor.primary20,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: AppColor.black40)
                          ),
                          child: Text(fileName,
                            style: CustomTextStyle.kTxtMedium.copyWith(
                                color: AppColor.black80,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(10.h),
                  Text(
                    "Upload a jpeg, jpg, pdf or png no larger than 100MB",
                    style: CustomTextStyle.kTxtRegular.copyWith(
                        color: AppColor.black80,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp),
                  ),
                  Gap(32.h),
                  CustomButton(onTap: (){
                    if(subjectController.text.isNotEmpty&&bodyController.text.isNotEmpty){
                      sendEmail(
                          emailAddress: "utilitypointsolution@gmail.com",
                          //  emailAddress: "ucheemekavictor@gmail.com",
                          body: bodyController.text,
                          subject: subjectController.text,
                          result: resultValue
                      );
                    }else{
                      AppUtils.showInfoSnack("No field should be empty", context);
                    }

                  },
                      buttonColor: AppColor.primary100,
                      textColor: AppColor.black0,
                      borderRadius: 8.r,
                      height: 58.h,
                      buttonText: "Submit Report")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  Future<void> pickFile() async {
    // Open the file picker and allow specific file types
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'jpg', 'pdf', 'png'],
      allowMultiple: false,
    );

    if (result != null) {
      // Get the picked file
      resultValue = result;
      PlatformFile file = result.files.first;

      // Check file size (should not be larger than 10MB)
      if (file.size <= 10 * 1024 * 1024) {
        setState(() {
          fileName= file.name;
        });
        AppUtils.showInfoSnack('File selected: ${file.name}',context);
        // Proceed with the file (e.g., upload or save)
      } else {
        AppUtils.showInfoSnack('File is too large. Maximum size is 10MB.',context);
      }
    } else {
      // User canceled the picker
      AppUtils.showInfoSnack('File selection canceled.',context);
    }
  }

  Future<void> sendEmail({
    required String emailAddress,
    String subject = '',
    String body = '',
    FilePickerResult? result
  }) async {
    String? attachmentPath;
    if (result != null && result.files.single.path != null) {
      attachmentPath = result.files.single.path;
    }

    // Construct the email with attachment
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [emailAddress],
      attachmentPaths: attachmentPath != null ? [attachmentPath] : [],
      isHTML: false,
    );

    // Send the email
    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      print('Could not send email: $error');
    }
  }

}
