
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
import 'package:utilitypoint/bloc/product/product_bloc.dart';
import 'package:utilitypoint/model/request/bvnOtpValidate.dart';
import 'package:utilitypoint/model/request/getProduct.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/utils/height.dart';
import 'package:utilitypoint/utils/reOccurringWidgets/transactionPin.dart';
import 'package:utilitypoint/view/home/home_screen.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

// import '../../../bloc/profile/profile_bloc.dart';
import '../../../model/response/userKYCResponse.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/myCustomCamera/myCameraScreen.dart';
import '../../../utils/myCustomCamera/secondCamera.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import '../validateBVNOtp.dart';
import 'checkImageQuality.dart';

class UserIdentityVerification extends StatefulWidget {
  const UserIdentityVerification({super.key});

  @override
  State<UserIdentityVerification> createState() => _UserIdentityVerificationState();
}

class _UserIdentityVerificationState extends State<UserIdentityVerification>  with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;

  late ProductBloc bloc;
  List<String> settings =[
    "Identity Verification",

  ];
  UserKycResponse? response;
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  CameraDescription? selectedCamera;
  bool isDriverLicence =false;
  bool isNIN =false;
  bool isInternational =false;
  bool isVoterCard =false;
  bool isBVN =false;
  bool isProfilePic =false;
  bool isAll =false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      bloc.add(GetAllUserUploadedKYCEvent(GetProductRequest(userId: loginResponse!.id)));
    });
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
  bool viewAll(){
    if(!isVoterCard||!isInternational||!isDriverLicence||!isNIN||!isProfilePic){
      return true;
    }else{
      return false;
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
        if(state is BVNVerified){
          WidgetsBinding.instance.addPostFrameCallback((_) async {
           var response= await Get.to(ValidateBVNOTPScreen(pinId: state.response.pinId??"",));
           if(response[0]){
             bloc.add(ValidateBVNOTPEvent(ValidateBvnOtpRequest(pinId: state.response.pinId??"",
               userId: loginResponse!.id, otp: response[1],)));
           }

          });
          bloc.initial();
        }
        if(state is ValidateBvnOtp){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              verificationStatus=1;
            });
            showSuccessSlidingModal(context,successMessage: "",
            headerText: "Sent for Verification",
            onTap: (){
              Get.back();
             // Get.back();
            });
          });
          bloc.initial();
        }
        if (state is UserKYCs) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            response = state.response;
            setState(() {
              if(response!.votersCard!.isNotEmpty){
                isVoterCard=true;
              }
              if(response!.internationalPassport!.isNotEmpty){
                isInternational=true;
              }
              if(response!.nin!.isNotEmpty){
                isNIN=true;
              }
              if(response!.driversLicense!.isNotEmpty){
                isDriverLicence=true;
              }
              if(response!.profilePicture!.isNotEmpty){
                isProfilePic=true;
              }
            });


          });
          bloc.initial();
        }
        return OverlayLoaderWithAppIcon(
            isLoading:state is ProductIsLoading,
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
              height: MediaQuery.of(context).size.height,
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
                  Visibility(
                      visible: isDriverLicence,
                      child: identityVerification(docImage: response?.driversLicense,title: "Driver's Licence")),
                  Visibility(
                      visible: isNIN,
                      child: identityVerification(docImage: response?.nin,title: "National Identity Number")),
                  Visibility(
                      visible: isInternational,
                      child: identityVerification(docImage: response?.internationalPassport,title: "International Passport")),
                  Visibility(
                      visible: isVoterCard,
                      child: identityVerification(docImage: response?.votersCard,title: "Voter's Card")),
                  Visibility(
                      visible: isProfilePic,
                      child: identityVerification(docImage: response?.profilePicture,title: "Profile Picture")),
                  BVNVerification(),
                      identityVerification(),
                  CustomButton(onTap: (){
                    bloc.add(GetAllUserUploadedKYCEvent(GetProductRequest(userId: loginResponse!.id)));
                  },
                    height: 58.h,
                    buttonText: "Get uploaded document(s)",
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
  Widget identityVerification({String? docImage,String? title}) {
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
            ( docImage==null||docImage.isEmpty)?
                Container(
                  height: 79.h,
                  width: 118.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage("assets/image/images_png/no_doc_new.png"),)
                  ),
                ):
            Container(
              height: 79.h,
              width: 118.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage(docImage),fit: BoxFit.cover)
              ),
            )
            ,
            Gap(15.h),
            Text(title==null?"Upload Document":title!,
              style: CustomTextStyle.kTxtBold.copyWith(
                  color: AppColor.black100,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp),
            ),
            Gap(16.h),
            SizedBox(
              height:36.h,
              width: 252.w,
              child:  Text(
                ( docImage==null||docImage.isEmpty)?
                "Take a driver’s license, national identity card or international passport, or update profile pic":
                "You have successfully uploaded your $title document",
                textAlign: TextAlign.center,
                style: CustomTextStyle.kTxtMedium.copyWith(
                    color: AppColor.black80,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp),
              ),
            ),
            Gap(16.h),
            ( docImage==null||docImage.isEmpty)?
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
                          height: 350.h,
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
                          child: Text("OK",
                            style: CustomTextStyle.kTxtMedium.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColor.primary100
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            Get.back();
                            await showCupertinoModalBottomSheet(
                            topRadius:
                            Radius.circular(20.r),
                            context: context,
                            backgroundColor:AppColor.primary20,
                            shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(24.r),topLeft: Radius.circular(24.r)),
                            ),
                            builder: (context) => SizedBox(
                                height: 350.h,
                                child: DocumentTypeBottomSheet())
                            );
                          },
                          child: Text("Select image from gallery",
                          style: CustomTextStyle.kTxtMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColor.primary100
                          ),
                          ),
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
            ):
                SizedBox(
                  height: 17.h,
                  width: 95.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/image/icons/checked_Icon.png",height: 14.h,width: 14.w,),
                      Gap(8.w),
                      Text("Done",
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.kTxtMedium.copyWith(
                            color: AppColor.success100,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp),
                      ),
                    ],
                  ),
                )
          ],
        ));
  }
  Widget BVNVerification() {
    return GestureDetector(
      onTap: () async {

      List<dynamic> result=  await showCupertinoModalBottomSheet(
        topRadius: Radius.circular(20.r),
        context: context,
        backgroundColor:AppColor.primary20,
        builder: (context) => Padding(
          padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
              height:400.h,
              child: VerifyBVN()),
        )
        );
      if(result[0]){
        bloc.add(VerifyBVNEvent(GetProductRequest(bvn:result[1],userId: loginResponse!.id)));
      }
      },
      child: Container(
          height: 150.h,
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
              Gap(10.h),
              Text("BVN Verification",
                style: CustomTextStyle.kTxtBold.copyWith(
                    color: AppColor.black100,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp),
              ),
              Gap(10.h),
              SizedBox(
                height:36.h,
                width: 252.w,
                child:  Text("Verify your BVN",
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.kTxtMedium.copyWith(
                      color: AppColor.black80,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp),
                ),
              ),
              verificationStatus==null || verificationStatus==0?
              SizedBox(
                height: 17.h,
                width: 95.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Icon(( verificationStatus==null || verificationStatus==0)?Icons.pending:
                     Icons.check_circle,color:( verificationStatus==null || verificationStatus==0)?AppColor.secondary100:AppColor.success100,size: 18,),
                    Gap(8.w),
                    Text(( verificationStatus==null || verificationStatus==0)?"Pending":"Verified",
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.secondary100,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                    ),
                  ],
                ),
              ):
              SizedBox(
                height: 17.h,
                width: 95.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/image/icons/checked_Icon.png",height: 14.h,width: 14.w,),
                    Gap(8.w),
                    Text("Done",
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.success100,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class DocumentTypeBottomSheet extends StatelessWidget {
  final CameraDescription? camera;
  bool? hasCamera;
   DocumentTypeBottomSheet({super.key, this.camera, this.hasCamera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: 350.h,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 30.w),
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
            Gap(15.h),
            Text("Which photo ID would you like to use?",
            style: CustomTextStyle.kTxtMedium.copyWith(
              color: AppColor.black80,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            ),
            Gap(20.h),
            GestureDetector(
              onTap: () async {
               // Get.to(CameraOverlayScreen(camera: camera,));
               // Get.to(CameraOption());
            List<dynamic>response= await showCupertinoModalBottomSheet(
                topRadius:
                Radius.circular(20.r),
                context: context,
                backgroundColor:AppColor.primary20,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(24.r),topLeft: Radius.circular(24.r)),
                ),
                builder: (context) => SizedBox(
                    height: 313.h,
                    child: CameraOption(hasCamera: hasCamera,))
                );
            if(response[0]!=null){
              print(response[0]);
              Get.to(CheckImageQuality(image:response[0],title: "drivers_license",),curve: Curves.easeIn);
            }
            print(response[0]);
              },
              child: SizedBox(
                height: 34.h,
                // width: 335.w,
                child: ColoredBox(
                  color: Colors.transparent,
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
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:12.w,vertical: 8.h),
              child: const Divider(color: AppColor.black40,),
            ),
            GestureDetector(
              onTap: () async {
                // Get.to(CameraOverlayScreen(camera: camera,));
                // Get.to(CameraOption());
               List<dynamic> response= await showCupertinoModalBottomSheet(
                    topRadius:
                    Radius.circular(20.r),
                    context: context,
                    backgroundColor:AppColor.primary20,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(24.r),topLeft: Radius.circular(24.r)),
                    ),
                    builder: (context) => SizedBox(
                        height: 313.h,
                        child:CameraOption(hasCamera: hasCamera,))
                );
                if(response[0]!=null){
                  print(response[0]);
                  Get.to(CheckImageQuality(image:response[0],title: "nin",),curve: Curves.easeIn);
                }
                print(response[0]);
              },
              child: SizedBox(
                height: 24.h,
                // width: MediaQuery.of(context).size.width.w,
                child: ColoredBox(
                  color: Colors.transparent,
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
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:12.w,vertical: 8.h),
              child: const Divider(color: AppColor.black40,),
            ),
            GestureDetector(
              onTap: () async {
                // Get.to(CameraOverlayScreen(camera: camera,));
                // Get.to(CameraOption());
             List<dynamic> response=   await showCupertinoModalBottomSheet(
                    topRadius:
                    Radius.circular(20.r),
                    context: context,
                    backgroundColor:AppColor.primary20,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(24.r),topLeft: Radius.circular(24.r)),
                    ),
                    builder: (context) => SizedBox(
                        height: 313.h,
                        child: CameraOption(hasCamera: hasCamera,))
                );
             if(response[0]!=null){
               print(response[0]);
               Get.to(CheckImageQuality(image:response[0],title: "international_passport",),curve: Curves.easeIn);
             }
              },
              child: SizedBox(
                height: 24.h,
                // width: 335.w,
                child: ColoredBox(
                  color: Colors.transparent,
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
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:12.w,vertical: 8.h),
              child: const Divider(color: AppColor.black40,),
            ),
            GestureDetector(
              onTap: () async {
                // Get.to(CameraOverlayScreen(camera: camera,));
                // Get.to(CameraOption());
                List<dynamic> response= await showCupertinoModalBottomSheet(
                    topRadius:
                    Radius.circular(20.r),
                    context: context,
                    backgroundColor:AppColor.primary20,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(24.r),topLeft: Radius.circular(24.r)),
                    ),
                    builder: (context) => SizedBox(
                        height: 313.h,
                        child:CameraOption(hasCamera: hasCamera,))
                );
                if(response[0]!=null){
                  print(response[0]);
                  Get.to(CheckImageQuality(image:response[0],title: "voters_card",),curve: Curves.easeIn);
                }
                print(response[0]);
              },
              child: SizedBox(
                height: 24.h,
                // width: 335.w,
                child: ColoredBox(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Voters Card",
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
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:12.w,vertical: 8.h),
              child: const Divider(color: AppColor.black40,),
            ),
            GestureDetector(
              onTap: () async {
                // Get.to(CameraOverlayScreen(camera: camera,));
                // Get.to(CameraOption());
            List<dynamic>response=   await showCupertinoModalBottomSheet(
                    topRadius:
                    Radius.circular(20.r),
                    context: context,
                    backgroundColor:AppColor.primary20,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(24.r),topLeft: Radius.circular(24.r)),
                    ),
                    builder: (context) => SizedBox(
                        height: 313.h,
                        child:CameraOption(hasCamera: hasCamera,))
                );
            if(response[0]!=null){
              print(response[0]);
              Get.to(CheckImageQuality(image:response[0],title: "profile_picture",),curve: Curves.easeIn);
            }
              },
              child: SizedBox(
                height: 24.h,
                // width: 335.w,
                child: ColoredBox(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Profile Picture",
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
            ),
          ],
        ),
      ) ,
    );
  }
}
class VerifyBVN extends StatefulWidget {
  const VerifyBVN({super.key});

  @override
  State<VerifyBVN> createState() => _VerifyBVNState();
}

class _VerifyBVNState extends State<VerifyBVN> {
  TextEditingController bvnController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:Container(
          height: 400.h,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: AppColor.black0,
            borderRadius: BorderRadius.only(topRight: Radius.circular(18.r),topLeft:  Radius.circular(18.r)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Gap(15.h),
              Text("Verify Your BVN?",
                style: CustomTextStyle.kTxtMedium.copyWith(
                  color: AppColor.black80,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              height8,
              CustomizedTextField(
                textEditingController: bvnController,
                keyboardType: TextInputType.number,
                readOnly: false,
                hintTxt: "Enter bvn",
                maxLength: 11,
              ),
              // height8,
              Text("Note: An OTP will be sent to the phone attached to your bvn.",
                style: CustomTextStyle.kTxtMedium.copyWith(
                  color: AppColor.black100,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gap(70.h),
              CustomButton(onTap: (){
                Get.back(result:[true, bvnController.text]);
              //  Get.to(ValidateBVNOTPScreen(pinId: "",));

              },
                buttonText: "Done",
                borderRadius: 8.r,
                height: 48.h,
                textColor: AppColor.black0,
                buttonColor: AppColor.primary100,),
              Gap(5.h),
              // CustomButton(onTap: (){
              //
              // },
              //   buttonText: "Cancel",
              //   borderRadius: 8.r,
              //   textColor:AppColor.secondary100 ,
              //   height: 28.h,
              //   buttonColor: Colors.transparent,),

              GestureDetector(
                onTap: (){
                  Get.back( result:[false, ""]);
                },
                child: Text("Cancel",
                  style: CustomTextStyle.kTxtBold.copyWith(
                    color:AppColor.secondary100,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}



