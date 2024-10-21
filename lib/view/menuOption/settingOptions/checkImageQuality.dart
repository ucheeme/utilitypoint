
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart'as diao;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image/image.dart'as img;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/bloc/product/product_bloc.dart';
import 'package:utilitypoint/model/request/getProduct.dart';
import 'package:utilitypoint/services/appUrl.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../../bloc/profile/profile_bloc.dart';
import '../../../model/response/userKYCResponse.dart';
import '../../../services/api_service.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/myCustomCamera/myCameraScreen.dart';
import '../../../utils/myCustomCamera/secondCamera.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';

class CheckImageQuality extends StatefulWidget {
  File? image;
  String? title;
   CheckImageQuality({super.key, this.image,this.title});

  @override
  State<CheckImageQuality> createState() => _CheckImageQualityState();
}

class _CheckImageQualityState extends State<CheckImageQuality>  with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;

  late ProductBloc bloc;
  String info ="";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      info = await checkImageQuality(widget.image!);
      setState(() {
        info=info;
      });
    });

    super.initState();
    _animationManager = SlideAnimationManager(this);

  }

  // Method to initialize available cameras and select one


  @override
  void dispose() {
    _animationManager.dispose();

    super.dispose();
  }
  Future<String> checkImageQuality(File imageFile) async {
    // Decode the image from the file
    final image = img.decodeImage(imageFile.readAsBytesSync());

    if (image == null) {
      return "Could not decode the image.";
    }

    // Define a threshold for sharpness; lower values are considered blurry.
    const sharpnessThreshold = 50;

    // Calculate sharpness by averaging pixel color differences (simple edge detection)
    double sharpness = 0.0;
    for (int y = 1; y < image.height - 1; y++) {
      for (int x = 1; x < image.width - 1; x++) {
        final pixel = image.getPixel(x, y);
        final pixelRight = image.getPixel(x + 1, y);
        final pixelDown = image.getPixel(x, y + 1);

        // Calculate the color difference between neighboring pixels
        sharpness += (pixel - pixelRight).abs() + (pixel - pixelDown).abs();
      }
    }

    // Normalize sharpness to get an average value
    sharpness /= (image.width * image.height);

    if (sharpness < sharpnessThreshold) {
      return "The image is not clear. Please take or upload another image.";
    } else {
      return "The image quality is acceptable.";
    }
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProductBloc>(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, () {
              AppUtils.showSnack(
                  state.errorResponse.message ?? "Error occurred", context);
            });
          });
          bloc.initial();
        }

        if (state is KYCUpdated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
          showSuccessSlidingModal(context,successMessage: "Document uploaded",
          onTap: (){
            Get.back();
            Get.back();
          }
          );
          });
          bloc.initial();
        }

        return OverlayLoaderWithAppIcon(
            isLoading:state is ProductIsLoading,
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
                  child: CustomAppBar(title: "Check quality")),
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
              child: ListView(
                padding: EdgeInsets.zero,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Container(
                   height: 233.h,
                   width: 247.w,
                   decoration: BoxDecoration(
                     image: DecorationImage(image:  Image.file(widget.image!,fit: BoxFit.contain,).image),
                     borderRadius: BorderRadius.all(Radius.circular(25.r))
                   ),

                 ),
                  Gap(32.h),
                  SizedBox(
                    height: 42.h,
                    width: Get.width,
                    child: Center(
                      child: Text(info,

                        style: CustomTextStyle.kTxtMedium.copyWith(
                        color: AppColor.black40,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp
                      ),),
                    ),
                  ),
                  Gap(140.h),
                  CustomButton(onTap: (){
                  // createKYC();
                    bloc.add(UploadUserKYCEvent(GetProductRequest(
                      userId: loginResponse!.id,
                      documentFile: widget.image,
                      documentCategory: widget.title
                    )));
                  },
                    height: 58.h,
                    buttonText: "Looks great! Continue",
                    textColor: AppColor.black0,
                    borderRadius: 8.r,
                    buttonColor: AppColor.primary100,
                  ),
                  Gap(10.h),
                  CustomButton(onTap: () async {
                   List<dynamic> result = await showCupertinoModalBottomSheet(
                    topRadius:
                    Radius.circular(20.r),
                    context: context,
                    backgroundColor:AppColor.primary20,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(24.r),topLeft: Radius.circular(24.r)),
                    ),
                    builder: (context) => SizedBox(
                        height: 313.h,
                        child: CameraOption())
                    );
                   if(result[0]!=null){
                     setState(() {
                       widget.image = result[0];
                     });
                   }
                  },
                    height: 58.h,
                    buttonText: "Take a new photo",
                    textColor: AppColor.secondary100,
                    borderRadius: 8.r,
                    buttonColor: Colors.transparent ,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  createKYC() async {
    var dio = diao.Dio();
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    var data = diao.FormData.fromMap({
      'user_id': '9d422285-4a44-444b-b93c-d903cdb2e0d6',
      'document_category': 'voters_card'
    });

  //  data.files.addAll();

    var response = await dio.request(
     AppUrls.uploadKYCDocumentC,
      options:  diao.Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    }
  }
}




