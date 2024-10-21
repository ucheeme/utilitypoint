
// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../model/request/confirmElectricityMeterOrCableName.dart';
import '../../../model/response/dataPlanResponse.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import '../../onboarding_screen/signIn/login_screen.dart';
import '../airtimePurchase/confirmPayment.dart';
import '../home_screen.dart';
import 'confirmMeterInfo.dart';

class RechargeMeter extends StatefulWidget {
  ProductPlanItemResponse planItemResponse;
  String meterType;
  String productPlanId;
  String productCategoryId;
   RechargeMeter({super.key,
     required this.productCategoryId,
     required this.planItemResponse,
     required this.productPlanId,
   required this.meterType});

  @override
  State<RechargeMeter> createState() => _RechargeMeterState();
}

class _RechargeMeterState extends State<RechargeMeter> with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;

  TextEditingController meterType = TextEditingController();
  TextEditingController meterNumber = TextEditingController();
  TextEditingController meterName = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool isLoadingContact = false;
  late ProductBloc bloc;

  @override
  void initState() {
    meterType.text = widget.meterType;
    super.initState();
    // Initialize the SlideAnimationManager
    _animationManager = SlideAnimationManager(this);
  }

  @override
  void dispose() {
    // Dispose the animation manager to avoid memory leaks
    _animationManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProductBloc>(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is CableNameConfirm){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            meterName.text= state.response.name.replaceAll("Defaulted to:", "");

          });
          bloc.initial();
        }
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
                  child: CustomAppBar(title: "Electricity")),
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
                children: [
                  SizedBox(
                    height: 103.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Meter Type",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 58.h,
                          child: CustomizedTextField(
                              textEditingController: meterType,
                              keyboardType: TextInputType.text,
                              readOnly: true,
                              isTouched: true),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 103.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Meter Number",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 58.h,
                          child: CustomizedTextField(
                              textEditingController: meterNumber,
                              keyboardType: TextInputType.text,
                              maxLength: 11,
                              onChanged: (value){
                                if(value.length==11){
                                  bloc.add(ConfirmCableNameEvent(
                                      ConfirmMeterOrCableNameRequest(
                                          userId: loginResponse!.id,
                                          pin:userDetails!.pin,
                                          smartCardNumber: value,
                                          productPlanId:widget.productPlanId
                                      )
                                  ));
                                }
                              },
                              readOnly: false,
                              isTouched: false),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 103.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Meter Name",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 58.h,
                          child: CustomizedTextField(
                              textEditingController: meterName,
                              keyboardType: TextInputType.text,
                              readOnly: true,
                              isTouched: true),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phone Number",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        GestureDetector(
                          onTap: (){
                            _pickContact();
                          },
                          child: Text(
                            "Select from contact",
                            style: CustomTextStyle.kTxtMedium.copyWith(
                                color: AppColor.primary100,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 58.h,
                    child: CustomizedTextField(
                        textEditingController: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        isTouched: false),
                  ),
                  Gap(10.h),
                  SizedBox(
                    height: 103.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Amount",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 58.h,
                          child: CustomizedTextField(
                              textEditingController: amount,
                              keyboardType: TextInputType.number,
                              readOnly: false,
                              isTouched: false),
                        ),

                      ],
                    ),
                  ),
                  CustomButton(
                    onTap: () async {
                      if(phoneNumberController.text.isNotEmpty&&meterNumber.text.isNotEmpty){
                        AirtimeRecharge firstValue=   AirtimeRecharge(
                          networkId: phoneNumberController.text,
                          number: meterNumber.text,
                          productPlanCategoryId: widget.productCategoryId,
                          networkName:meterType.text,
                          networkIcon: "",
                          amount: amount.text,
                          cableName: meterName.text,
                        );
                        Get.to(ConfirmElectricPayment(airtimeRecharge: firstValue,
                          productPlanList: widget.planItemResponse,));
                      }else{
                        AppUtils.showSnack("No Field should be empty", context);
                      }

                    },
                    buttonText: "Next",
                    buttonColor: AppColor.primary100,
                    textColor: AppColor.black0,
                    borderRadius: 8.r,
                    height: 58.h,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Future<void> _pickContact() async {
    setState(() {
      isLoadingContact=true;
    });

    final PermissionStatus permissionStatus = await Permission.contacts.request();
    if (permissionStatus == PermissionStatus.granted) {

      final Contact? contact = await FlutterContacts.openExternalPick();
      if (contact != null) {
        setState(() {
          // _selectedContactName = contact.displayName ?? '';
          phoneNumberController.text = contact.phones!.isNotEmpty ? contact.phones!.first.number! : '';
          // contactName.text=_selectedContactName;
          // bloc.data.whatsappPhoneNumber(_selectedContactName);
          // bloc.data.setFullName(_selectedContactName);
          // whatsappNumbe.text =_selectedContactPhoneNumber.replaceAll(" ", "");
          //  isLoadingContact =false;
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Permission Denied"),
          content: Text("The app needs contact permission to function."),
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
      print('Permission not granted');
    }
  }

}
