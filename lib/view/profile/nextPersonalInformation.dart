import 'package:country_code_picker/country_code_picker.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/utils/mySharedPreference.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../main.dart';
import '../../model/request/updateUserRequest.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/app_util.dart';
import '../../utils/customAnimation.dart';
import '../../utils/image_paths.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/text_style.dart';
import '../home/home_screen.dart';
import '../onboarding_screen/signIn/login_screen.dart';

class Nextpersonalinformation extends StatefulWidget {
  UpdateUserDetailRequest updateUserDetailRequest;
   Nextpersonalinformation({super.key, required this.updateUserDetailRequest});

  @override
  State<Nextpersonalinformation> createState() => _NextpersonalinformationState();
}

class _NextpersonalinformationState extends State<Nextpersonalinformation>  with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  bool isLightMode = false;
  TextEditingController countryController = TextEditingController(text: "NG");
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bvnController = TextEditingController();
  TextEditingController ninController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  late ProfileBloc bloc;
  bool enableEdit=true;
  @override
  void initState() {
    if( isNewAccount){
      enableEdit = true;
    }
    countryController.text ="NG";
    stateController.text =userDetails!.state??"";
    cityController.text =userDetails!.city??"";
    postalCode.text =userDetails!.postalCode??"";
    addressController.text =userDetails!.addressStreet??"";
    bvnController.text =userDetails!.identificationNumber??"";
    ninController.text =userDetails!.identityNumber??"";
    dobController.text = userDetails!.dob??"";
    userDetails!.identityType ="NIN";
    userDetails!.identificationType ="BVN";
    maskText = true;
    maskText2 = true;
    super.initState();
    // Initialize the SlideAnimationManager
    _animationManager = SlideAnimationManager(this);
  }
  bool maskText = false;
  bool maskText2 = false;
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
        if (state is ProfileError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, () {
              AppUtils.showSnack("${state.errorResponse.message}", context);
            });
          });
          bloc.initial();
        }
        if (state is UserDetailUpdate) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isNewAccount = false;
            print("Done");
            MySharedPreference.setIsProfileUpdate(isNewAccount);
            userDetails!.firstName = state.response.firstName;
            userDetails!.lastName = state.response.lastName;
            userDetails!.otherNames = widget.updateUserDetailRequest.otherNames;
            userDetails!.userName =loginResponse!.userName;
            userDetails!.email = state.response.email;
            userDetails!.phoneNumber = state.response.phoneNumber;
            userDetails!.country="NG";
            userDetails!.state= stateController.text;
            userDetails!.city=cityController.text;
            userDetails!.postalCode=postalCode.text ;
            userDetails!.addressStreet=addressController.text;
            userDetails!.identificationNumber=bvnController.text;
            userDetails!.identityNumber=ninController.text;
            userDetails!.identityType ="NIN";
            userDetails!.identificationType ="BVN";
            userDetails!.dob = dobController.text;
            showSuccessSlidingModal(context,
                headerText: "Details Updated!",
                successMessage: "User Details Update was successful!");
          });
         // Get.back();
          bloc.initial();
        }
        return OverlayLoaderWithAppIcon(
            isLoading: state is ProfileIsLoading,
            overlayBackgroundColor: AppColor.black40,
            circularProgressColor: AppColor.primary100,
            appIconSize: 60.h,
            appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
            child: GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                },
                child: Scaffold(body: appBodyDesign(getBody(context),context: context))));
      },
    );
  }

  Widget getBody(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SlideTransition(
            position: _animationManager.slideAnimationTop,
            child: Padding(
              padding: EdgeInsets.only(top: 52.h, left: 20.w, bottom: 17.h),
              child: SizedBox(
                  height: 52.h,
                  child: CustomAppBar(title: "Personal Information")),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _animationManager.slideAnimation,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColor.primary20,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r)),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [

                  SizedBox(
                    height: 88.h,
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 88.h,
                          width:MediaQuery.of(context).size.width*0.40,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Country",
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.black100,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp),
                              ),
                              Gap(2.h),
                              SizedBox(
                                  height: 58.h,
                                  child: CustomizedTextField(
                                      readOnly: true,
                                      textEditingController: countryController,
                                      isProfile: false)),
                            ],
                          ),
                        ),
                        // Gap(20.w),
                        SizedBox(
                          height: 88.h,
                          width: MediaQuery.of(context).size.width*0.40,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "State",
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.black100,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp),
                              ),
                              Gap(2.h),
                              GestureDetector(
                               // onTap: () => _showStatesBottomSheet(context),
                                child: SizedBox(
                                    height: 58.h,
                                    child: CustomizedTextField(
                                        readOnly: true,
                                        onTap:  () => _showStatesBottomSheet(context),
                                        textEditingController: stateController,
                                        isProfile: false)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(14.h),
                  SizedBox(
                    height: 88.h,
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 88.h,
                         width: MediaQuery.of(context).size.width*0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "City",
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.black100,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp),
                              ),
                              Gap(2.h),
                              SizedBox(
                                  height: 58.h,
                                  child: CustomizedTextField(
                                      readOnly: enableEdit,
                                      textEditingController: cityController,
                                      isProfile: false)),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 88.h,
                         width: MediaQuery.of(context).size.width*0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Postal Code",
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.black100,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp),
                              ),
                              Gap(2.h),
                              SizedBox(
                                  height: 58.h,
                                  child: CustomizedTextField(
                                      readOnly: enableEdit,
                                      keyboardType: TextInputType.number,
                                      textEditingController: postalCode,
                                      isProfile: false)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(14.h),
                  SizedBox(
                    height: 88.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Address",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        Gap(2.h),
                        SizedBox(
                            height: 58.h,
                            child: CustomizedTextField(
                                readOnly: enableEdit,
                                textEditingController: addressController,
                                isProfile: false)),
                      ],
                    ),
                  ),
                  Gap(14.h),
                  SizedBox(
                    height: 88.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter NIN",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        Gap(2.h),
                        SizedBox(
                            height: 58.h,
                            child: CustomizedTextField(
                              textEditingController: ninController,
                              keyboardType: TextInputType.number,
                              maxLength: 11,
                              readOnly: enableEdit,
                              surffixWidget: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    maskText2=!maskText2;
                                  });
                                },
                                child:Padding(
                                  padding:  EdgeInsets.only(right: 16.w),
                                  child:  maskText2? Image.asset(
                                    ic_eye_open,
                                    height: 24.h,
                                    width: 24.h,
                                  ):Image.asset(
                                    ic_eye_close,
                                    height: 24.h,
                                    width: 24.h,
                                  ),
                                ),
                              ),
                              obsec: maskText2,
                              hintTxt: "22222222222",
                            )),
                      ],
                    ),
                  ),
                  Gap(14.h),
                  SizedBox(
                    height: 88.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter Date of Birth",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        Gap(2.h),
                        SizedBox(
                            height: 58.h,
                            child: CustomizedTextField(
                              textEditingController: dobController,
                              keyboardType: TextInputType.datetime,
                              readOnly: true,
                              onTap:!enableEdit? (){
                                _selectDate(dobController);
                              }:(){},
                              hintTxt: "1972-05-24",
                            )),
                      ],
                    ),
                  ),
                  Gap(64.h),
                  !enableEdit?
                  CustomButton(
                    onTap: () {
                      if (checkIfFieldsAreFilled()) {
                          if(ninController.text=="22222222222"){
                            AppUtils.showInfoSnack("Please change your details", context);
                          }else{
                            bloc.add(UpdateUserDetailsEvent(
                                UpdateUserDetailRequest(
                                    userId: loginResponse!.id,
                                    firstName:widget.updateUserDetailRequest.firstName,
                                    lastName: widget.updateUserDetailRequest.lastName,
                                    otherNames: widget.updateUserDetailRequest.otherNames,
                                    //  userName: widget.updateUserDetailRequest.userName,
                                    // phoneNumber: widget.updateUserDetailRequest.phoneNumber.trim(),
                                    addressStreet: addressController.text,
                                    identificationNumber: ninController.text.trim(),
                                    identificationType: "NIN",
                                    identityType: "BVN",
                                    state: stateController.text.trim(),
                                    city: cityController.text.trim(),
                                    country: countryController.text.trim(),
                                    // identityNumber: bvnController.text.trim(),
                                    identityImage: userDetails?.profilePic??"https://default_image.png",
                                    photo:userDetails?.profilePic??"https://default_image.png",
                                    postalCode: postalCode.text.trim(),
                                    dob: dobController.text.trim()
                                )
                            ));
                          }
                        }
                        else {
                          null;
                        }
                    },
                    buttonText: "Save Changes",
                    textColor: AppColor.black0,
                    buttonColor: checkIfFieldsAreFilled()
                        ? AppColor.primary100
                        : AppColor.primary40,
                    borderRadius: 8.r,
                    height: 58.h,
                    textfontSize: 16.sp,
                  ):
                  CustomButton(
                    onTap: () {

                        setState(() {
                          enableEdit = !enableEdit;
                        });

                      },
                    buttonText: "Edit Info",
                    textColor: AppColor.black0,
                    buttonColor: checkIfFieldsAreFilled()
                        ? AppColor.primary100
                        : AppColor.primary40,
                    borderRadius: 8.r,
                    height: 58.h,
                    textfontSize: 16.sp,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  bool checkIfFieldsAreFilled() {
    if (countryController.text.isEmpty ||
        stateController.text.isEmpty ||
        cityController.text.isEmpty ||
        postalCode.text.isEmpty ||
        addressController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
  Future<void> _selectDate(TextEditingController controller,
      {String labelText = "",}) async {
    DateTime? response = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1890),
        lastDate: DateTime(2100));

    if (response != null) {

      setState(() {
        controller.text = response.format("Y-m-d");
        // if(isExpiryDate){
        //   expiredDate=response.format("m/d/Y h:i A");
        // }
        labelText = controller.text;
      });
    }
  }
  final List<String> _nigeriaStates = [
    "Abia",
    "Adamawa",
    "Akwa Ibom",
    "Anambra",
    "Bauchi",
    "Bayelsa",
    "Benue",
    "Borno",
    "Cross River",
    "Delta",
    "Ebonyi",
    "Edo",
    "Ekiti",
    "Enugu",
    "Gombe",
    "Imo",
    "Jigawa",
    "Kaduna",
    "Kano",
    "Katsina",
    "Kebbi",
    "Kogi",
    "Kwara",
    "Lagos",
    "Nasarawa",
    "Niger",
    "Ogun",
    "Ondo",
    "Osun",
    "Oyo",
    "Plateau",
    "Rivers",
    "Sokoto",
    "Taraba",
    "Yobe",
    "Zamfara",
    "FCT (Abuja)"
  ];

  void _showStatesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Column(
         // mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Select a State",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: _nigeriaStates.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_nigeriaStates[index]),
                    onTap: () {
                      Navigator.of(context).pop(_nigeriaStates[index]);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    ).then((selectedState) {
      if (selectedState != null) {
        // Do something with the selected state
        stateController.text = selectedState;
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("You selected: $selectedState")),
        // );
      }
    });
  }
}
