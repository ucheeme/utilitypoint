import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:utilitypoint/utils/text_style.dart';

import '../app_color_constant.dart';


File tempImageP=File("");
class CameraOption extends StatefulWidget {
  bool? hasCamera;
   CameraOption({super.key, this.hasCamera}) ;

  @override
  State<CameraOption> createState() => _CameraOptionState();
}

class _CameraOptionState extends State<CameraOption> {
  // CameraController? _controller;
  @override
  void initState() {

    super.initState();
  }

  bool isNotEmpty=false;
  List<String> images=[];

  File? _image;
  String? _base64Image;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    // final pickedFile = await picker.getImage(source: source);
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _resizeAndEncodeImage();
      }
    });


  }
  Future<void> _resizeAndEncodeImage() async {
    final fileSize = await _image!.length();

    if (fileSize > 300 * 1024) {
      // Image size is greater than 300KB, resize the image
      final tempDir = await getTemporaryDirectory();
      final tempPath = path.join(tempDir.path, path.basename(_image!.path));

      img.Image? image = img.decodeImage(_image!.readAsBytesSync());
      final resizedImage = img.copyResize(image!, width: 800);

      File(tempPath).writeAsBytesSync(img.encodeJpg(resizedImage));

      setState(() {
        _image = File(tempPath);
        tempImageP=File(tempPath);
      });
      _cropImage(_image!,tempPath);
    } else {
      _cropImage(_image!,_image!.path);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    //  _controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: 220.h,
        color: AppColor.primary20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,

              height: 53.h,
              child: Padding(
                padding:  EdgeInsets.only(left: 20.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Image upload",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                        color: AppColor.black100,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400
                      )
                  ),
                ),
              ),
            ),
            Gap(20.h),
            GestureDetector(
              onTap: () async {
                if(widget.hasCamera==null || widget.hasCamera==true){
                  await getImage(ImageSource.camera);
                }


              },
              child: Container(
                width: double.infinity,
                height: 54.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.h),
                  child:
                  Text("Take a picture with your camera",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.black80,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                      )
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                getImage(ImageSource.gallery);
              },
              child: Container(
                width: double.infinity,
                height: 54.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.h),
                  child:
                  Text("Upload from device",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.black80,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _cropImage(File imgFile,String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      uiSettings:[
        AndroidUiSettings(
            toolbarTitle: "Image Cropper",
            toolbarColor: AppColor.primary100,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ]
        ),
        IOSUiSettings(
          title: "Image Cropper",
          showCancelConfirmationDialog: true,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio16x9
          ],
        )
      ]
    );
    CircularProgressIndicator(color: AppColor.primary100,);
    if (croppedFile != null) {

      imageCache.clear();
      setState(() {
        _image= File(croppedFile.path);
        _base64Image = base64Encode(_image!.readAsBytesSync());
      });
      // reload();
    }else{
      setState(() {
        _image= File(imgFile.path);
        _base64Image = base64Encode(_image!.readAsBytesSync());
      });
    }
    Get.back(result:[ _image,_base64Image]);
  }
}

void requestCameraPermission(context) async {
  var status = await Permission.camera.request();
  if (status.isGranted) {

  } else if (status.isDenied) {
    final snackBar=SnackBar(
      content: Text('Camera permission denied!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else if (status.isPermanentlyDenied) {

  }
}

void checkCameraPermission(context) async {
  var status = await Permission.camera.status;
  if (status.isGranted) {

  } else {
    requestCameraPermission(context);
  }
}