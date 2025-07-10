import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/bloc/card/virtualcard_bloc.dart';
import 'package:utilitypoint/bloc/onboarding_new/onBoardingValidator.dart';
import 'package:utilitypoint/model/request/getProduct.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/view/home/home_screen.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../model/request/updateUserRequest.dart';
import '../../model/response/nairaFundingOptions.dart';
import '../../model/response/userVirtualAccounts.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/app_util.dart';
import '../../utils/customAnimation.dart';
import '../../utils/notice.dart';
import '../../utils/pages.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/text_style.dart';
import '../bottomNav.dart';
import '../menuOption/convertFunds/convert.dart';
import '../menuOption/settingOptions/verifyIdentity.dart';
import '../profile/nextPersonalInformation.dart';
import 'fundNairaOption.dart';

class FundWalletScreen extends StatefulWidget {
  bool isFundDollarWallet ;
   FundWalletScreen({super.key, required this.isFundDollarWallet});

  @override
  State<FundWalletScreen> createState() => _FundWalletScreeState();
}

class _FundWalletScreeState extends State<FundWalletScreen>  with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();
  late VirtualcardBloc bloc;
  List<UserVirtualAccouts> userVirtualAccounts= [];
  bool isUser=false;
  bool isCrystalPay=false;
  bool isFlutterWave=false;
  bool isNGNWallet=false;
  bool isBankTransfer=false;
  bool isNewVirtualAccount=false;
  List<NairaFundingOptions> nairaFundingOptions= [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      //print(widget.isFundDollarWallet);
      //  bloc.add(GetExchangeRateEvent());
      if(verificationStatus == 0||verificationStatus ==null){
        openBottomSheet(
            context,
            NoticeBottomSheet(
              image:
              "assets/image/icons/attentionAlert.png-removebg-preview.png",
              title: "Update your KYC information",
              body:
              "Validate your KYC information and perform transaction",
              onTap: () {
                Get.to(UserIdentityVerification());
              },
            ), ).then((_){
              Get.offAll(MyBottomNav());
        });
      }else{
        if(widget.isFundDollarWallet==false){
          bloc.add(GetUserVirtualAccountEvent(GetProductRequest(userId: loginResponse!.id,pin: userDetails!.pin)));
        }else{
          bloc.add(GetExchangeRateEvent());
        }
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
  _callFundScreen(bool isUSDFundScreen){
    if(isUSDFundScreen){
      showSlidingModalFundScreen(context,
      ngnWalletTransfer: (){
        setState(() {
          isUser=true;
          isNGNWallet=false;
          isBankTransfer =false;
        });
      },
      userNameReceive: (){
        setState(() {
          isUser=true;
          isNGNWallet=false;
          isBankTransfer =false;
        });
        // AppUtils.showInfoSnackFromBottom("Coming Soon", context);
      },
      bankTransfer: (){
        setState(() {
          isUser=false;
          isNGNWallet=false;
          isBankTransfer =true;
        });
        // AppUtils.showInfoSnackFromBottom("Coming Soon", context);
      }
      );
    }else{

    }
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<VirtualcardBloc>(context);
    return BlocBuilder<VirtualcardBloc, VirtualcardState>(
      builder: (context, state) {
        if (state is VirtualcardError){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, (){
              AppUtils.showSnack(state.errorResponse.message ?? "Error occurred", context);
            });
          });
          bloc.initial();
        }

        if (state is ExchangeRate){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            currencyConversionRateFees =state.response;
            _callFundScreen(widget.isFundDollarWallet);
          });
          bloc.initial();
        }

        if (state is NairaFundingOptionFound){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            nairaFundingOptions =state.response;
            setState(() {
              isNewVirtualAccount=true;
            });
          });
          bloc.initial();
        }
        if (state is AllUserVirtualAccounts){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            userVirtualAccounts=state.response;
            if(userVirtualAccounts.isEmpty){
              setState(() {
                isNewVirtualAccount=true;
              });
              bloc.add(GetNairaFundingOptionsEvent());
            }else{
              setState(() {
                isNewVirtualAccount=false;
              });
            }
           // bloc.add(GetNairaFundingOptionsEvent());
          });
          bloc.initial();
        }

        return OverlayLoaderWithAppIcon(
            isLoading:state is VirtualcardIsLoading,
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
                  child: CustomAppBar(title: "Fund Wallet")),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _animationManager.slideAnimation,
            child: Container(
              height:MediaQuery.of(context).size.height,
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 24.w),
              decoration: BoxDecoration(
                color: AppColor.primary20,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r)),
              ),
              child:(userVirtualAccounts.isEmpty||isNewVirtualAccount)? Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      bloc.add(GetUserVirtualAccountEvent(GetProductRequest(
                          userId: loginResponse!.id,pin: userDetails!.pin)));
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("View All Virtual Accounts",
                        style: CustomTextStyle.kTxtMedium.copyWith(
                            color: AppColor.primary100,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  ...nairaFundingOptions.mapIndexed((element,index)=>
                      GestureDetector(
                        onTap: (){
                          if(element.fundingOptionName.toLowerCase()=="crystal pay"){
                           Get.to(FundNairaWalletSection(bankCodes:element.bankCodes));
                          }else if(element.fundingOptionName.toLowerCase()=="flutterwave"){

                          }
                          setState(() {
                          });
                        },
                        child: index==0?listButtons(title: element.fundingOptionName):
                            SizedBox()
                      )
                  )
                  // GestureDetector(
                  //     onTap: (){
                  //       Get.to(FundNairaWalletSection(bankCodes:nairaFundingOptions[0].bankCodes));
                  //     },
                  //     child: listButtons(title:nairaFundingOptions[0].fundingOptionName))
                ],
              ):
              Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      bloc.add(GetNairaFundingOptionsEvent());
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("Generate virtual account",
                        style: CustomTextStyle.kTxtMedium.copyWith(
                            color: AppColor.primary100,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  ...userVirtualAccounts.mapIndexed((element,index)=>
                      GestureDetector(
                          onTap: (){
                           // 4601904919
                          },
                          child:  Container(
                            height: 96.h,
                            padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 5.h),
                            margin: EdgeInsets.symmetric(vertical: 14.h),
                            decoration: BoxDecoration(
                              border: Border.all(color:isUser?AppColor.primary100:AppColor.black60),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    offset: Offset(0, 8)),
                              ],
                              color: isUser?AppColor.primary30:AppColor.black0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Bank name:",
                                      style: CustomTextStyle.kTxtBold.copyWith(
                                          color:isUser?AppColor.primary100:AppColor.black100,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Gap(20.w),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        element.bankName,
                                        style: CustomTextStyle.kTxtBold.copyWith(
                                            color:isUser?AppColor.primary100:AppColor.black100,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Acct. Name:",
                                      style: CustomTextStyle.kTxtBold.copyWith(
                                          color:isUser?AppColor.primary100:AppColor.black100,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Gap(10.w),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: SizedBox(
                                        width: 200.w,
                                        child: Text(element.accountName,
                                          style: GoogleFonts.inter(
                                              color: AppColor.black80,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Acct. No:",
                                      style: CustomTextStyle.kTxtBold.copyWith(
                                          color:isUser?AppColor.primary100:AppColor.black100,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Gap(20.w),
                                    Text(element.accountNumber,
                                      style: GoogleFonts.inter(
                                          color: AppColor.black80,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),


                              ],
                            ),
                          )
                      )
                  )
                ],
              )
              ,
            ),
          )
        ],
      ),
    );
  }
  // Container(
  // height: 70.h,
  // padding: EdgeInsets.symmetric(horizontal: 12.w),
  // margin: EdgeInsets.symmetric(vertical: 14.h),
  // decoration: BoxDecoration(
  // border: Border.all(color:isUser?AppColor.primary100:AppColor.black60),
  // borderRadius: BorderRadius.circular(12.r),
  // boxShadow: const [
  // BoxShadow(
  // color: Colors.black12,
  // blurRadius: 8,
  // offset: Offset(0, 8)),
  // ],
  // color: isUser?AppColor.primary30:AppColor.black0,
  // ),
  // child: Column(
  // crossAxisAlignment: CrossAxisAlignment.start,
  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  // children: [
  // Align(
  // alignment: Alignment.centerLeft,
  // child: Text(
  // element.fundingOptionName,
  // style: CustomTextStyle.kTxtBold.copyWith(
  // color:isUser?AppColor.primary100:AppColor.black100,
  // fontSize: 14.sp,
  // fontWeight: FontWeight.w400),
  // ),
  // ),
  // Text("Get funds from users with your username",
  // style: GoogleFonts.inter(
  // color: AppColor.black80,
  // fontSize: 12.sp,
  // fontWeight: FontWeight.w400),
  // )
  // ],
  // ),
  // ),
}
