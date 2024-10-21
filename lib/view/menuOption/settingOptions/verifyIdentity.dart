
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/utils/constant.dart';

import '../../../bloc/profile/profile_bloc.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/myCustomCamera/myCameraScreen.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';

class UserIdentityVerification extends StatefulWidget {
  const UserIdentityVerification({super.key});

  @override
  State<UserIdentityVerification> createState() => _UserIdentityVerificationState();
}

class _UserIdentityVerificationState extends State<UserIdentityVerification>  with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;

  late ProfileBloc bloc;
  List<String> settings =[
    "Identity Verification",

  ];

  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  CameraDescription? selectedCamera;
  @override
  void initState() {
    super.initState();
    _animationManager = SlideAnimationManager(this);
    _initializeCameras();
  }

  // Method to initialize available cameras and select one
  Future<void> _initializeCameras() async {
    try {
      // Get the list of available cameras on the device
      cameras = await availableCameras();

      // Select a camera (e.g., first camera in the list, typically the rear camera)
      if (cameras != null && cameras!.isNotEmpty) {
        selectedCamera = cameras!.first;  // You can change this to choose front camera, etc.

        // Initialize the CameraController with the selected camera
        _cameraController = CameraController(
          selectedCamera!,
          ResolutionPreset.max,
        );

        // Initialize the camera controller
        await _cameraController!.initialize();

        setState(() {});
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _animationManager.dispose();
    _cameraController?.dispose();
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
                  child: CustomAppBar(title: "Verify Identity")),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  identityVerification(),
                  CustomButton(onTap: (){},
                    height: 58.h,
                    buttonText: "Verify my identity",
                    textColor: AppColor.black0,
                    borderRadius: 8.r,
                    buttonColor: AppColor.primary100,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget identityVerification() {
    return Container(
        height: 241.h,
        width: 335.w,
        margin: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 8)),
          ],
          color: AppColor.black0,
        ),
        padding: EdgeInsets.symmetric(horizontal: 9.5.w, vertical: 10.h),
        child: Column(
          children: [
            Gap(16.2.h),
            Image.asset("assets/image/icons/governmentId_Icon.png",height: 79.h,width: 118.w,),
            Gap(15.h),
            Text("Government ID",
              style: CustomTextStyle.kTxtBold.copyWith(
                  color: AppColor.black100,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp),
            ),
            Gap(16.h),
            SizedBox(
              height:36.h,
              width: 252.w,
              child:  Text("Take a driver’s license, national identity card or international passport.",
                textAlign: TextAlign.center,
                style: CustomTextStyle.kTxtMedium.copyWith(
                    color: AppColor.black80,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp),
              ),
            ),
            Gap(16.h),
            GestureDetector(
              onTap: () async {
                if(selectedCamera!=null){
                  await showCupertinoModalBottomSheet(
                      topRadius:
                      Radius.circular(20.r),
                      context: context,
                      backgroundColor:AppColor.primary20,
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(24.r),topLeft: Radius.circular(24.r)),
                      ),
                      builder: (context) => SizedBox(
                          height: 313.h,
                          child: DocumentTypeBottomSheet(camera: selectedCamera!,))
                  );
                }else{
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text("NO Camera Detected",
                      style: CustomTextStyle.kTxtBold.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),),
                      content: Text("This app needs to access you camera to perform some operations",
                        style: CustomTextStyle.kTxtMedium.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Grant Permission"),
                        )
                      ],
                    ),
                  );
                }

              },
              child: SizedBox(
                height: 17.h,
                width: 95.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/image/icons/fi_camera.png",height: 14.h,width: 14.w,color: AppColor.primary100,),
                    Text("Take a photo",
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.primary100,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class DocumentTypeBottomSheet extends StatelessWidget {
  final CameraDescription camera;
   DocumentTypeBottomSheet({super.key,required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: 313.h,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.black0,
          borderRadius: BorderRadius.only(topRight: Radius.circular(18.r),topLeft:  Radius.circular(18.r)),
        ),
        child: Column(
          children: [
            Gap(8.h),
            Container(
              height: 6.h,
              width: 48.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.r),
                color: AppColor.black40
              ),
            ),
            Gap(27.h),
            Text("Which photo ID would you like to use?",
            style: CustomTextStyle.kTxtMedium.copyWith(
              color: AppColor.black80,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            ),
            Gap(43.h),
            GestureDetector(
              onTap: (){
                Get.to(CameraOverlayScreen(camera: camera,));
              },
              child: SizedBox(
                height: 24.h,
                width: 335.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Driver's License",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                        color: AppColor.black100,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios,color: AppColor.black60,size: 20,)
                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:12.w,vertical: 12.h),
              child: const Divider(color: AppColor.black40,),
            ),
            GestureDetector(
              onTap: (){

              },
              child: SizedBox(
                height: 24.h,
                width: 335.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("National Identity Card(NIN)",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                        color: AppColor.black100,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios,color: AppColor.black60,size: 20,)
                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:12.w,vertical: 12.h),
              child: const Divider(color: AppColor.black40,),
            ),
            GestureDetector(
              onTap: (){

              },
              child: SizedBox(
                height: 24.h,
                width: 335.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("International Passport",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                        color: AppColor.black100,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios,color: AppColor.black60,size: 20,)
                  ],
                ),
              ),
            ),

          ],
        ),
      ) ,
    );
  }
}



