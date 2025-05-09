// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:utilitypoint/utils/constant.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../model/request/getProduct.dart';
import '../../../model/response/dataPlanCategory.dart';
import '../../../model/response/dataPlanResponse.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/reuseableFunctions.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import '../../onboarding_screen/signIn/login_screen.dart';
import '../home_screen.dart';
import 'confirmBulkPayment.dart';
import 'confirmPayment.dart';

class BulkAirtimeScreen extends StatefulWidget {
  const BulkAirtimeScreen({super.key});

  @override
  State<BulkAirtimeScreen> createState() => _BulkAirtimeScreenState();
}

class _BulkAirtimeScreenState extends State<BulkAirtimeScreen>  with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  bool isMTN = true;
  bool isAirtel = false;
  bool isGlo = false;
  bool is9Mobile = false;
  bool isLoadingContact=false;
  String networkId ="";
  String networkName ="";
  List<String> firstAmount =["100","200","500","1000"];
  List<String> secondAmount =["1500","2000","5000","10000"];
  int selectedValue =0;
  String networkValidation = "";
  String airtimeCategotyId ="";
  TextEditingController phoneNumberController =TextEditingController();
  TextEditingController airtimeAmountController =TextEditingController();
  List<ProductPlanCategoryItem> productPlanCategoryList=[];
  List<ProductPlanItemResponse> productPlanList=[];
  List<String> multiplePhoneNumbers=[];
  List<TextEditingController> multipleTextController=[];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(appAllNetworkList.isEmpty||appAllNetworkList==null){
        bloc.add(GetAllNetworkEvent());
      }
      else{
        networkName="MTN";
        for(var item in appAllNetworkList){
          if(item.networkName.toLowerCase() =="mtn"){
            setState(() {
              networkId = item.id;
            });
          }
        }
        bloc.add(GetAllProductPlanCategoryEvent(GetProductRequest(
            networkId: networkId,
            productSlug: "airtime"
        )));
      }
    });
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
  late ProductBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProductBloc>(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductError){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, (){
              AppUtils.showSnack(state.errorResponse.message ?? "Error occurred", context);
            });
          });
          bloc.initial();
        }
        if (state is AllProductPlanCategories){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            productPlanCategoryList= state.response;
            airtimeCategotyId =productPlanCategoryList[0].id;
          });
          bloc.initial();
        }
        if (state is ProductAllNetworks) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            appAllNetworkList = state.response;
            networkName="MTN";
            for(var item in appAllNetworkList){
              if(item.networkName.toLowerCase() =="mtn"){
                setState(() {
                  networkId = item.id;
                });
              }
            }
            bloc.add(GetAllProductPlanCategoryEvent(GetProductRequest(
                networkId: networkId,
                productSlug: "airtime"
            )));
          });
          bloc.initial();
        }
        if (state is AllProductPlanSuccess){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            productPlanList= state.response;
            Get.to(BulkAirtimeConfirmPayment(
              airtimeRecharge:AirtimeRecharge(
                  networkId: networkId,
                  number:  phoneNumberController.text,
                  productPlanCategoryId: airtimeCategotyId,
                  networkName: networkName,
                  networkIcon:  getNetworkIcon(networkName),
                  amount:   airtimeAmountController.text.trim()),
              productPlanList: productPlanList,
              phonenumbers: multiplePhoneNumbers,));
          });
          bloc.initial();
        }

        return OverlayLoaderWithAppIcon(
            isLoading: state is ProductIsLoading,
            overlayBackgroundColor: AppColor.black40,
            circularProgressColor: AppColor.primary100,
            appIconSize: 60.h,
            appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
            child: GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                },
                child: Scaffold(body: appBodyDesign(getBody()))));
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
                  child: CustomAppBar(title: "Buy bulk airtime")),
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Network",
                      style: CustomTextStyle.kTxtBold.copyWith(
                          color: AppColor.black100,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp),
                    ),
                    SizedBox(
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          dashboardIcons(
                              title: "MTN",
                              icon: "mtn_Icon",
                              onTap: () {
                                for(var item in appAllNetworkList){
                                  if(item.networkName.toLowerCase() =="mtn"){
                                    setState(() {
                                      networkId = item.id;
                                      networkName="MTN";
                                      isMTN = true;
                                      isAirtel = false;
                                      isGlo = false;
                                      is9Mobile=false;
                                    });
                                  }
                                }
                                bloc.add(GetAllProductPlanCategoryEvent(GetProductRequest(
                                    networkId: networkId,
                                    productSlug: "airtime"
                                )));
                                String networkType= getNetworkProvider(phoneNumberController.text);
                                if(networkType.toLowerCase()!=networkName.toLowerCase()){
                                  setState(() {
                                    networkValidation="The number you entered is not an $networkName number, but a $networkType";
                                  });
                                  // AppUtils.showSnack("The number you entered is not an $networkName number", context);
                                }

                              },
                              isSelected: isMTN),
                          dashboardIcons(
                              title: "Airtel",
                              icon: "airtel_Icon",
                              onTap: () {
                                for(var item in appAllNetworkList){
                                  if(item.networkName.toLowerCase() =="airtel"){
                                    setState(() {
                                      networkId = item.id;
                                      networkName="Airtel";
                                      isMTN = false;
                                      isAirtel = true;
                                      isGlo = false;
                                      is9Mobile=false;
                                    });
                                  }
                                }
                                bloc.add(GetAllProductPlanCategoryEvent(GetProductRequest(
                                    networkId: networkId,
                                    productSlug: "airtime"
                                )));
                                String networkType= getNetworkProvider(phoneNumberController.text);
                                if(networkType.toLowerCase()!=networkName.toLowerCase()){
                                  setState(() {
                                    networkValidation="The number you entered is not an $networkName number, but a $networkType";
                                  });
                                  // AppUtils.showSnack("The number you entered is not an $networkName number", context);
                                }

                              },
                              isSelected: isAirtel),
                          dashboardIcons(
                              title: "Glo",
                              icon: "glo_Icon",
                              onTap: () {
                                for(var item in appAllNetworkList){
                                  if(item.networkName.toLowerCase() =="glo"){
                                    setState(() {
                                      networkId = item.id;
                                      networkName="Glo";
                                      isMTN = false;
                                      isAirtel = false;
                                      isGlo = true;
                                      is9Mobile=false;
                                    });
                                  }
                                }
                                bloc.add(GetAllProductPlanCategoryEvent(GetProductRequest(
                                    networkId: networkId,
                                    productSlug: "airtime"
                                )));
                                String networkType= getNetworkProvider(phoneNumberController.text);
                                if(networkType.toLowerCase()!=networkName.toLowerCase()){
                                  setState(() {
                                    networkValidation="The number you entered is not an $networkName number, but a $networkType";
                                  });
                                  // AppUtils.showSnack("The number you entered is not an $networkName number", context);
                                }

                                // Get.to(ConvertScreen());
                              },
                              isSelected: isGlo),
                          dashboardIcons(
                              title: "9 Mobile",
                              icon: "9mobile_Icon",
                              onTap: () {
                                for(var item in appAllNetworkList){
                                  if(item.networkName.toLowerCase() =="9mobile"){
                                    setState(() {
                                      networkId = item.id;
                                      networkName="9 Mobile";
                                      isMTN = false;
                                      isAirtel = false;
                                      isGlo = false;
                                      is9Mobile=true;
                                    });
                                  }
                                }
                                bloc.add(GetAllProductPlanCategoryEvent(GetProductRequest(
                                    networkId: networkId,
                                    productSlug: "airtime"
                                )));
                                String networkType= getNetworkProvider(phoneNumberController.text);
                                if(networkType.toLowerCase()!=networkName.toLowerCase()){
                                  setState(() {
                                    networkValidation="The number you entered is not an $networkName number, but a $networkType";
                                  });
                                  // AppUtils.showSnack("The number you entered is not an $networkName number", context);
                                }

                                // Get.to(ConvertScreen());
                              },
                              isSelected: is9Mobile),
                        ],
                      ),
                    ),
                    Gap(10.h),
                    Text(
                      "Airtime Category",
                      style: CustomTextStyle.kTxtBold.copyWith(
                          color: AppColor.black100,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp),
                    ),
                    SizedBox(
                      width: Get.width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ...productPlanCategoryList.mapIndexed((element, index)=>
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 10.w),
                                  child: dashboardIcons(
                                      title:getTitle(element.productPlanCategoryName,networkName),
                                      icon: getNetworkIcon(networkName),
                                      onTap: () {
                                        airtimeCategotyId=element.id;
                                        setState(() {
                                          selectedValue=index;
                                        });

                                        // for(var item in appAllNetworkList){
                                        //   if(item.networkName.toLowerCase() =="mtn"){
                                        //
                                        //   }
                                        // }

                                      },
                                      isSelected:selectedValue==index),
                                ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Gap(10.h),
                    SizedBox(
                      height: 91.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.h,
                            child: Text(
                              "Amount",
                              style: CustomTextStyle.kTxtBold.copyWith(
                                  color: AppColor.black100,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                          ),
                          SizedBox(
                            height: 58.h,
                            child: CustomizedTextField(
                                textEditingController: airtimeAmountController,
                                keyboardType:TextInputType.number,
                                isTouched: false),
                          ),
                        ],
                      ),
                    ),
                    Gap(16.h),
                    SizedBox(
                      height: 200.h,
                      child: Column(
                        children: [
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ...firstAmount.mapIndexed((element, index)=>
                                    GestureDetector(
                                        onTap:(){
                                          setState(() {
                                            airtimeAmountController.text=element;
                                          });

                                        },
                                        child: airtimeCard(title: element))
                                )
                              ],
                            ),
                          ),
                          // Gap(10.h),
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ...secondAmount.mapIndexed((element, index)=>
                                    GestureDetector(
                                        onTap:(){
                                          setState(() {
                                            airtimeAmountController.text=element;
                                          });
                                        },
                                        child: airtimeCard(title: element))
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 103.h,
                      child: Column(
                        children: [
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
                                onChanged:(value){
                                  if(value.length>6){
                                    String networkType= getNetworkProvider(value);
                                    if(networkType.toLowerCase()!=networkName.toLowerCase()){
                                      setState(() {
                                        networkValidation="The number you entered is not a/an $networkName number, please proceed if you are certain of the network type";
                                      });
                                      // AppUtils.showSnack("The number you entered is not an $networkName number", context);
                                    }
                                  }
                                  setState(() {

                                  });
                                },
                                isTouched: false),
                          ),
                            Text(
                            networkValidation,
                            style: CustomTextStyle.kTxtMedium.copyWith(
                                color: AppColor.Error100,
                                fontWeight: FontWeight.w400,
                                fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height:multipleTextController.isEmpty?0.h:multipleTextController.length*80.h,
                        child: Column(
                          children: [
                            ...multipleTextController.mapIndexed((element,index)=>
                                Container(
                                  //color: Colors.yellow,
                                  //width:295.w,
                                  height: 60.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:290.w,
                                        child: CustomizedTextField(
                                            keyboardType: TextInputType.phone,
                                            textEditingController: multipleTextController[index],
                                            onChanged: (value){
                                              setState(() {
                                                multiplePhoneNumbers[index]=value;
                                              });
                                            },
                                            isTouched: false
                                        ),
                                      ),
                                      Gap(10.w),
                                      GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              multipleTextController.removeAt(index);
                                              multiplePhoneNumbers.removeAt(index);
                                            });
                                          },
                                          child: Image.asset("assets/image/icons/bulk_delete_Icon.png",
                                            height: 24.h,width: 24.w,))
                                    ],
                                  ),
                                )
                            )
                          ],
                        )
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          multipleTextController.add(TextEditingController());
                          multiplePhoneNumbers.add(multipleTextController.last.text);
                        });
                      },
                      child: Visibility(
                        visible: phoneNumberController.text.isEmpty?false:true,
                        child: SizedBox(
                          height: 30.h,
                          child: Row(
                            children: [
                            Icon(Icons.add_circle_outline,color: AppColor.primary100,),
                              Gap(5.w),
                              Text(
                                "Add another number",
                                style: CustomTextStyle.kTxtMedium.copyWith(
                                    color: AppColor.primary100,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Gap(40.h),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                        onTap: () async {
                          if(multiplePhoneNumbers.length>2||multiplePhoneNumbers.isEmpty){
                            AppUtils.showInfoSnack("Please enter more than one(1) phone number",  context);
                          }else{
                            print("You have ${multiplePhoneNumbers.length} phone numbers");
                            if(airtimeAmountController.text.isNotEmpty&&phoneNumberController.text.isNotEmpty){
                              // multiplePhoneNumbers.removeAt(0);
                              bloc.add(GetAllProductPlanEvent(GetProductRequest(
                                  userId: loginResponse!.id,
                                  planCategoryId:airtimeCategotyId,
                                  amount: airtimeAmountController.text.trim(),
                                  networkId: networkId,
                                  productSlug: "airtime"
                              )));
                            }else if(!airtimeAmountController.text.isNumericOnly||!phoneNumberController.text.isNumericOnly){
                              AppUtils.showSnack("Please enter only digits", context);
                            }else{
                              AppUtils.showSnack("Please ensure no field is empty", context);
                            }
                          }

                        },
                        buttonText: "Next",
                        buttonColor: AppColor.primary100,
                        textColor: AppColor.black0,
                        borderRadius: 8.r,
                        height: 58.h,
                      ),
                    )
                  ],
                ),
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

          if(phoneNumberController.text.isEmpty){
            phoneNumberController.text = contact.phones!.isNotEmpty ?
            contact.phones!.first.number.replaceAll(" ", "")! : '';
          }
          if( phoneNumberController.text.isNotEmpty){
            print("this is the valueee.....  ${multipleTextController.length}");
            setState(() {
              multipleTextController.last.text = contact.phones!.isNotEmpty ?
              contact.phones!.first.number.replaceAll(" ", "")! : '';
              // multiplePhoneNumbers.add(multipleTextController.last.text);
              multiplePhoneNumbers.last=multipleTextController.last.text;
            });
          }

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

  String getNetworkIcon(String title){
    switch (title){
      case "MTN": return "mtn_Icon";
      case "Airtel": return "airtel_Icon";
      case "Glo": return "glo_Icon";
      case "9 Mobile": return "9mobile_Icon";
      default: return "mtn_Icon";
    }
  }
  String getTitle(String title,String networkName){
    String response = "";
    if(title.toLowerCase().contains("virtual top up")){
      return title.replaceAll("(Virtual Top Up)","");
    }else{
      return    title.replaceAll("AIRTIME", "")
          .replaceAll(networkName, "")
          .replaceAll("(", "")
          .replaceAll(")", "");
    }
  }
}

