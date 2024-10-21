import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:utilitypoint/bloc/product/product_bloc.dart';
import 'package:utilitypoint/model/request/getProduct.dart';
import 'package:utilitypoint/model/response/airtimeDatatransactionHistory.dart';
import 'package:utilitypoint/model/response/nairaDollarTransactionList.dart';
import 'package:utilitypoint/model/response/userDetails.dart';
import 'package:utilitypoint/model/response/userKYCStatusResponse.dart';
import 'package:utilitypoint/model/response/userSetting.dart';
import 'package:utilitypoint/utils/text_style.dart';
import 'package:utilitypoint/view/home/moreOptions.dart';
import 'package:utilitypoint/view/menuOption/convertFunds/convert.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../model/response/networksList.dart';
import '../../model/response/products.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/app_util.dart';
import '../../utils/customClipPath.dart';
import '../../utils/notice.dart';
import '../../utils/reusable_widget_two.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/route.dart';
import '../bottomNav.dart';
import '../fundWallet/fund_wallet.dart';
import '../menuOption/cards/virtualCardScreens.dart';
import 'airtimePurchase/productListScreen.dart';
import 'cable/cableListView.dart';
import 'dataPurchase/dataScreen.dart';
import 'electricity/electricityListView.dart';

List<NetworkList> appAllNetworkList = [];
List<UserGeneralSettings> appAllSettingsList = [];
List<Products> appAllProductList = [];
List<ProductTransactionList> airtimeDataTransactionHistory = [];
UserDetails? userDetails;
int? verificationStatus;
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentWallet = 0;
  late ProductBloc bloc;
  DateTime currentDateTime = DateTime.now();
  List<NairaTransactionList> transactionList =[];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (appAllNetworkList.isEmpty) {
        bloc.add(GetAllNetworkEvent());
      }
      if (appAllProductList.isEmpty) {
        bloc.add(GetAllProductEvent());
      }
      bloc.add(GetUserDetails(GetProductRequest(userId: loginResponse!.id)));
      bloc.add(GetUserSettingsEvent());
      if (currencyConversionRateFees == null) {
        bloc.add(GetExchangeRateEvent());
      }
      bloc.add(GetUserKYCStatusEvent(GetProductRequest(userId: loginResponse!.id)));
      bloc.add(GetAllUserUploadedKYCEvent(GetProductRequest(userId: loginResponse!.id)));
      bloc.add(GetAllNairaWalletTransactionsEvent(GetProductRequest(
        userId: loginResponse!.id,
        startDate: "${currentDateTime.year}-${currentDateTime.month}-01",
        endDate:"${currentDateTime.year}-${currentDateTime.month}-${_getLastDayOfTheMonth()}",
      )));
    });
    super.initState();
  }

  int _getLastDayOfTheMonth(){
    DateTime firstDayOfNextMonth = (currentDateTime.month < 12)
        ? DateTime(currentDateTime.year, currentDateTime.month + 1, 1)
        : DateTime(currentDateTime.year + 1, 1, 1);

    // Subtract one day to get the last day of the current month
    DateTime lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
    return lastDayOfCurrentMonth.day;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bloc = BlocProvider.of<ProductBloc>(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {

        if (state is ProductError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, () {
              AppUtils.showSnack(state.errorResponse.message, context);
            });
          });
          bloc.initial();
        }
        if (state is ProductAllNetworks) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            appAllNetworkList = state.response;
          });
          bloc.initial();
        }
        if (state is AllUserDetails) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            userDetails = state.response;
          });
          bloc.initial();
        }
        if (state is UserKYCVerificationStatus) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            verificationStatus= state.response.verificationStatus;
            if(verificationStatus==0){
              var result= await openBottomSheet(
                  context,
                  NoticeBottomSheet(
                image: "assets/image/icons/attentionAlert.png-removebg-preview.png",
                title: "Update your KYC information",
                body: "Validate your KYC information and perform transaction",));
            }
          });
          bloc.initial();
        }
        if (state is UserKYCs) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            userDetails!.profilePic= state.response.profilePicture;
          });
          bloc.initial();
        }
        if (state is AllProduct) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            appAllProductList = state.response;
          });
          bloc.initial();
        }

        if (state is AllUserDetails) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            userDetails = state.response;
          });
          bloc.initial();
        }
        if (state is GeneralSettings) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            appAllSettingsList = state.response;
          });
          bloc.initial();
        }

        if(state is AllNairaTransactions){
          WidgetsBinding.instance.addPostFrameCallback((_){
            for(var item in state.response){
              transactionList.add(item);
            }

          });
          bloc.initial();
        }

        if (state is ProductExchangeRate) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            currencyConversionRateFees = state.response;
          });
          bloc.initial();
        }

        return OverlayLoaderWithAppIcon(
          isLoading: state is ProductIsLoading,
          overlayBackgroundColor: AppColor.black40,
          circularProgressColor: AppColor.primary100,
          appIconSize: 60.h,
          appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
          child: Scaffold(
            backgroundColor: AppColor.primary20,
            body: ListView(
              padding: EdgeInsets.zero,
              children: [
                dashboardHeader(
                    initialPage: _currentWallet,
                    onPageChanged: (integer, page) {
                      setState(() {
                        _currentWallet = integer;
                      });
                    },
                    depositOnTap: depositOnTap(),
                    accountBalance: accountBalance(),
                    isNaira: _currentWallet == 0 ? true : false,
                    sideBarOnTap: () {
                      //Navigator.of(context).push(createFlipRoute(Moreoptions()));
                      Get.to(Moreoptions(), curve: Curves.easeIn);
                    }),
                Center(
                  child: CarouselIndicator(
                    color: AppColor.black00,
                    count: 2,
                    activeColor: AppColor.primary100,
                    index: _currentWallet,
                  ),
                ),
                Gap(32.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quick Access",
                        style: CustomTextStyle.kTxtBold.copyWith(
                          color: AppColor.black100,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                      Gap(18.h),
                      SizedBox(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            dashboardIcons(
                                horizontal: 0,
                                onTap: () async {
                                  if(verificationStatus==0){
                                    var result= await openBottomSheet( context,  NoticeBottomSheet(
                                      image: "assets/image/icons/attentionAlert.png-removebg-preview.png",
                                      title: "Update your KYC information",
                                      body: "Validate your KYC information and perform transaction",));
                                  }else{   Get.to(
                                      FundWalletScreen(
                                        isFundDollarWallet: true,
                                      ),
                                      curve: Curves.easeIn);

                                  }

                                }),
                            dashboardIcons(
                                title: "Buy Data",
                                icon: "data_Icon",
                                onTap: () {
                                  Get.to(AllData(), curve: Curves.easeIn);
                                }),
                            dashboardIcons(
                                title: "Dollar Card",
                                icon: "dollardCard",
                                onTap:  () async {
                                  if(verificationStatus==0){
                                    var result= await openBottomSheet( context,  NoticeBottomSheet(
                                      image: "assets/image/icons/alertAttention.png",
                                      title: "Update your KYC information",
                                      body: "Validate your KYC information and perform transaction",));
                                  }else{
                                    Get.to(VirtualCards(isNaira: false,),curve: Curves.easeIn);
                                  }

                                }),
                            dashboardIcons(
                                title: "Convert",
                                icon: "convert",
                                onTap:  () async {
                                  if(verificationStatus==0){
                                    var result= await openBottomSheet( context,  NoticeBottomSheet(
                                      image: "assets/image/icons/alertAttention.png",
                                      title: "Update your KYC information",
                                      body: "Validate your KYC information and perform transaction",));
                                  }else{
                                    Get.to(ConvertScreen(
                                      isTopUpCard: false,
                                      isCreateCard: false,
                                    ));
                                  }

                                }),
                          ],
                        ),
                      ),
                      Gap(18.h),
                      SizedBox(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            dashboardIcons(
                                horizontal: 0,
                                title: "Buy Airtime",
                                icon: "buyAirtime",
                                onTap: () {
                                  Get.to(BuySingleAirtime());
                                }),
                            dashboardIcons(
                                title: "Cable TV",
                                icon: "cableTv",
                                onTap: () {
                                  Get.to(CableListView());
                                }),
                            dashboardIcons(
                                title: "Electricity",
                                icon: "electricity",
                                onTap: () {
                                  Get.to(ElectricityListView());
                                }),
                            dashboardIcons(
                                title: "More",
                                icon: "more_Icon",
                                onTap: () {
                                  Get.to(const Moreoptions(),curve: Curves.easeIn);
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(28.h),
                transactionList.isEmpty?
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Image.asset("assets/image/images_png/Card.png"),
                ):
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 14.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Transaction History",
                                style: CustomTextStyle.kTxtMedium.copyWith(
                                  color: AppColor.black100,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16.sp
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.offAll(MyBottomNav(position: 1,), predicate: (route) => false);
                                },
                                child: Text("View all",
                                  style: CustomTextStyle.kTxtMedium.copyWith(
                                      color: AppColor.primary100,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16.sp
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 500.h,
                            child:  ListView.builder(
                                padding: EdgeInsets.only(top: 10.h),
                                itemCount:transactionList.length>10?10:transactionList.length,
                                itemBuilder: (context,index){
                                  NairaTransactionList element=transactionList[index];
                                  return Padding(
                                    padding:  EdgeInsets.only(bottom:12.h),
                                    child: NairaTransactionWidgetDesgin(transactionList: element,),
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
              ],
            ),
          ),
        );
      },
    );
  }

  double accountBalance() {
    return _currentWallet == 0
                      ? double.parse(userDetails == null
                          ? "0"
                          : userDetails!.nairaWallet)
                      : double.parse(userDetails == null
                          ? "0"
                          : userDetails!.dollarWallet);
  }

  Function() depositOnTap() {
    return _currentWallet == 0
                      ? () {
                          Get.to(
                              FundWalletScreen(
                                isFundDollarWallet: false,
                              ),
                              curve: Curves.easeIn);
                        }
                      : () {
                          Get.to(
                              FundWalletScreen(
                                isFundDollarWallet: true,
                              ),
                              curve: Curves.easeIn);
                        };
  }
}
