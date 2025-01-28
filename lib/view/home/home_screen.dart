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
import 'package:utilitypoint/main.dart';
import 'package:utilitypoint/model/request/getProduct.dart';
import 'package:utilitypoint/model/request/updateUserRequest.dart';
import 'package:utilitypoint/model/response/airtimeDatatransactionHistory.dart';
import 'package:utilitypoint/model/response/nairaDollarTransactionList.dart';
import 'package:utilitypoint/model/response/userDetails.dart';
import 'package:utilitypoint/model/response/userKYCStatusResponse.dart';
import 'package:utilitypoint/model/response/userSetting.dart';
import 'package:utilitypoint/utils/mySharedPreference.dart';
import 'package:utilitypoint/utils/text_style.dart';
import 'package:utilitypoint/view/home/moreOptions.dart';
import 'package:utilitypoint/view/menuOption/convertFunds/convert.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';
import 'package:utilitypoint/view/profile/nextPersonalInformation.dart';
import 'package:utilitypoint/view/profile/personalInformation.dart';

import '../../model/response/networksList.dart';
import '../../model/response/products.dart';
import '../../model/response/userKYCResponse.dart';
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
import 'airtimePurchase/airtimeProductListScreen.dart';
import 'cable/cableListView.dart';
import 'dataPurchase/dataScreen.dart';
import 'electricity/electricityListView.dart';
UserKycResponse? userKycResponse;
List<NetworkList> appAllNetworkList = [];
List<UserGeneralSettings> appAllSettingsList = [];
List<Products> appAllProductList = [];
List<ProductTransactionList> airtimeDataTransactionHistory = [];
UserDetails? userDetails;
int? verificationStatus;
bool isHomePageWallet = false;

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentWallet = 0;
  late ProductBloc bloc;

  DateTime currentDateTime = DateTime.now();
  List<ProductTransactionList> transactionList = [];
  List<ProductTransactionList> dollarTransactionList = [];
  bool isLoading = false;
  bool isCardRelated = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isNewAccount = MySharedPreference.getIsProfileUpdate();
      if (isNewAccount) {
        openBottomSheet(
            context,
            NoticeBottomSheet(
              image:
                  "assets/image/icons/attentionAlert.png-removebg-preview.png",
              title: "Update your Profile Details",
              body: "Finish Setting up your profile",
              onTap: () {
                Get.to(Nextpersonalinformation(
                    updateUserDetailRequest: UpdateUserDetailRequest(
                  userId: loginResponse!.id,
                  firstName: loginResponse!.firstName,
                  lastName: loginResponse!.lastName,
                  otherNames: userDetails!.otherNames,
                )));
              },
            ));
      }
      if (userDetails == null) {
      //  isLoading=true;
      bloc.add(GetUserDetails(GetProductRequest(userId: loginResponse!.id)));
      }
      if (appAllNetworkList.isEmpty||appAllNetworkList==null) {
        bloc.add(GetAllNetworkEvent());
      }
      //
      if (appAllProductList.isEmpty) {
        bloc.add(GetAllProductEvent());
      }

      if (appAllSettingsList.isEmpty) {
        bloc.add(GetUserSettingsEvent());
      }

      if (currencyConversionRateFees == null) {
        bloc.add(GetExchangeRateEvent());
      }
      bloc.add(
          GetUserKYCStatusEvent(GetProductRequest(userId: loginResponse!.id)));
      bloc.add(GetAllUserUploadedKYCEvent(
          GetProductRequest(userId: loginResponse!.id)));
      bloc.add(GetProductTransactionHistoryEvent(GetProductRequest(
        userId: loginResponse!.id,
        dateFrom: "${currentDateTime.year}-${currentDateTime.month}-01",
        dateTo:
        "${currentDateTime.year}-${currentDateTime.month}-${_getLastDayOfTheMonth()}",
      )));
    });
    super.initState();
  }

  int _getLastDayOfTheMonth() {
    DateTime firstDayOfNextMonth = (currentDateTime.month < 12)
        ? DateTime(currentDateTime.year, currentDateTime.month + 1, 1)
        : DateTime(currentDateTime.year + 1, 1, 1);

    // Subtract one day to get the last day of the current month
    DateTime lastDayOfCurrentMonth =
        firstDayOfNextMonth.subtract(Duration(days: 1));
    return lastDayOfCurrentMonth.day;
  }

  bool isVisibleAmount = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bloc = BlocProvider.of<ProductBloc>(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductError) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (state.errorResponse.message.toLowerCase() ==
                "kyc data not found" && isCardRelated== true) {
              var result = await openBottomSheet(
                  context,
                  NoticeBottomSheet(
                    image:
                        "assets/image/icons/attentionAlert.png-removebg-preview.png",
                    title: "Update your KYC information",
                    body:
                        "Validate your KYC information and perform transaction",
                  ));
              isCardRelated = false;
            } else {
              if(state.errorResponse.message.toLowerCase() ==
                  "kyc data not found" ){

              }else{
                Future.delayed(Duration.zero, () async {
                  AppUtils.showSnack(state.errorResponse.message, context);
                });
              }

            }
          });
          bloc.initial();
        }
        if (state is ProductAllNetworks) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            appAllNetworkList = state.response;
            if (userDetails == null) {
              isLoading = true;
              bloc.add(GetUserDetails(GetProductRequest(userId: loginResponse!.id)));
            }
          });
          bloc.initial();
        }
        if (state is AllUserDetails) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            print("this is the username: ${state.response.userName}");
            userDetails = state.response;
            setState(() {
              userDetails=userDetails;
              isLoading = false;
            });
          });
          bloc.initial();
        }
        if (state is UserKYCVerificationStatus) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            verificationStatus = state.response.verificationStatus;
            if (userDetails == null) {
              isLoading = true;
              bloc.add(
                  GetUserDetails(GetProductRequest(userId: loginResponse!.id)));
            }
            if (verificationStatus == 0  && isCardRelated== true) {
              var result = await openBottomSheet(
                  context,
                  NoticeBottomSheet(
                    image:
                        "assets/image/icons/attentionAlert.png-removebg-preview.png",
                    title: "Update your KYC information",
                    body:
                        "Validate your KYC information and perform transaction",
                  ));
            }
              isCardRelated = false;
          });
          bloc.initial();
        }
        if (state is UserKYCs) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            userDetails?.profilePic = state.response?.profilePicture;
            if (userDetails == null) {
              isLoading = true;
              bloc.add(
                  GetUserDetails(GetProductRequest(userId: loginResponse!.id)));
            }
            // userImage.value=state.response?.profilePicture!;
          });
          bloc.initial();
        }
        if (state is AllProduct) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            appAllProductList = state.response;
            if (userDetails == null) {
              isLoading = true;
              bloc.add(
                  GetUserDetails(GetProductRequest(userId: loginResponse!.id)));
            }
          });
          bloc.initial();
        }
        if (state is AirtimeDataTransactionHistorySuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            for (var item in state.response) {
              if(transactionList.length<11){
                transactionList.add(item);
              }
            }

          });
          bloc.initial();
        }
        if (state is GeneralSettings) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            appAllSettingsList = state.response;
            if (userDetails == null) {
              isLoading = true;
              bloc.add(
                  GetUserDetails(GetProductRequest(userId: loginResponse!.id)));
            }
          });
          bloc.initial();
        }

        // if (state is AllNairaTransactions) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     for (var item in state.response) {
        //       transactionList.add(item);
        //     }
        //     if (userDetails == null) {
        //       isLoading = true;
        //       bloc.add(
        //           GetUserDetails(GetProductRequest(userId: loginResponse!.id)));
        //     }
        //   });
        //   bloc.initial();
        // }
        // if (state is AllDollarTransactions) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     for (var item in state.response) {
        //       dollarTransactionList.add(item);
        //     }
        //     if (isHomePageWallet) {
        //       Get.back();
        //       _showDollarWalletBottomSheet(context);
        //     }
        //   });
        //   bloc.initial();
        // }
        if (state is ProductExchangeRate) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            currencyConversionRateFees = state.response;
            if (userDetails == null) {
              isLoading = true;
              bloc.add(
                  GetUserDetails(GetProductRequest(userId: loginResponse!.id)));
            }
          });
          bloc.initial();
        }

        return OverlayLoaderWithAppIcon(
          isLoading: isLoading || state is ProductIsLoading,
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
                    withdrawOnTap: () {
                      setState(() {
                        isHomePageWallet = true;
                      });
                      bloc.add(
                          GetAllDollarWalletTransactionsEvent(GetProductRequest(
                        userId: loginResponse!.id,
                        startDate:
                            "${currentDateTime.year}-${currentDateTime.month}-01",
                        endDate:
                            "${currentDateTime.year}-${currentDateTime.month}-${_getLastDayOfTheMonth()}",
                      )));
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24.r)),
                        ),
                        builder: (context) => DraggableScrollableSheet(
                          expand: false,
                          initialChildSize: 0.5,
                          maxChildSize: 1.0,
                          minChildSize: 0.3,
                          builder: (context, scrollController) {
                            return SizedBox(
                              height: 300.h,
                              child: Container(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.primary100,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    onPressed: () {
                      setState(() {
                        isVisibleAmount = !isVisibleAmount;
                      });
                    },
                    isVisibleAmount: isVisibleAmount,
                    depositOnTap: depositOnTap(),
                    accountBalance: accountBalance(),
                    isNaira: _currentWallet == 0 ? true : false,
                    sideBarOnTap: () {
                      //Navigator.of(context).push(createFlipRoute(Moreoptions()));
                      // Get.to(Moreoptions(), curve: Curves.easeIn);
                      Get.to(PersonInformation(), curve: Curves.easeIn);
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
                                title: "Fund Dollar Wallet",
                                onTap: () async {
                                  setState(() {
                                    isCardRelated = true;
                                  });
                                  if (verificationStatus == 0||verificationStatus ==null) {
                                    var result = await openBottomSheet(
                                        context,
                                        NoticeBottomSheet(
                                          image:
                                              "assets/image/icons/attentionAlert.png-removebg-preview.png",
                                          title: "Update your KYC information",
                                          body:
                                              "Validate your KYC information and perform transaction",
                                        ));
                                  } else {
                                    Get.to(
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
                                onTap: () async {
                                  setState(() {
                                    isCardRelated = true;
                                  });
                                  if (verificationStatus == 0||verificationStatus ==null) {
                                    var result = await openBottomSheet(
                                        context,
                                        NoticeBottomSheet(
                                          image:
                                              "assets/image/icons/attentionAlert.png-removebg-preview.png",
                                          title: "Update your KYC information",
                                          body:
                                              "Validate your KYC information and perform transaction",
                                        ));
                                  } else {
                                    Get.to(
                                        VirtualCards(
                                          isNaira: false,
                                        ),
                                        curve: Curves.easeIn);
                                  }
                                }),
                            dashboardIcons(
                                title: "Convert",
                                icon: "convert",
                                onTap: () async {
                                  setState(() {
                                    isCardRelated = true;
                                  });
                                  if (verificationStatus == 0||verificationStatus ==null) {
                                    var result = await openBottomSheet(
                                        context,
                                        NoticeBottomSheet(
                                          image:
                                              "assets/image/icons/attentionAlert.png-removebg-preview.png",
                                          title: "Update your KYC information",
                                          body:
                                              "Validate your KYC information and perform transaction",
                                        ));
                                  } else {
                                    if (userDetails == null) {
                                      openBottomSheet(
                                          context,
                                          Container(
                                            height: 300.h,
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: AppColor.primary100,
                                              ),
                                            ),
                                          ));
                                      bloc.add(GetUserDetails(GetProductRequest(
                                          userId: loginResponse!.id)));
                                    }
                                    if (userDetails != null) {
                                      Get.to(ConvertScreen(
                                        isTopUpCard: false,
                                        isCreateCard: false,
                                      ));
                                    }
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
                                  Get.to(const Moreoptions(),
                                      curve: Curves.easeIn);
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(28.h),
                transactionList.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Image.asset("assets/image/images_png/Card.png"),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Transaction History",
                                  style: CustomTextStyle.kTxtMedium.copyWith(
                                      color: AppColor.black100,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16.sp),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.offAll(
                                        MyBottomNav(
                                          position: 1,
                                        ),
                                        predicate: (route) => false);
                                  },
                                  child: Text(
                                    "View all",
                                    style: CustomTextStyle.kTxtMedium.copyWith(
                                        color: AppColor.primary100,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16.sp),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 500.h,
                              child: ListView.builder(
                                  padding: EdgeInsets.only(top: 10.h),
                                  itemCount: transactionList.length > 10
                                      ? 10
                                      : transactionList.length,
                                  itemBuilder: (context, index) {
                                    ProductTransactionList element =
                                        transactionList[index];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 12.h),
                                      child: NairaTransactionWidgetDesgin(
                                        transactionList: element,
                                      ),
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
        ? double.parse(userDetails == null ? "0" : userDetails!.nairaWallet)
        : double.parse(userDetails == null ? "0" : userDetails!.dollarWallet);
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

  // void _showDollarWalletBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
  //     ),
  //     builder: (context) => DraggableScrollableSheet(
  //       expand: false,
  //       initialChildSize: 0.5,
  //       maxChildSize: 1.0,
  //       minChildSize: 0.3,
  //       builder: (context, scrollController) {
  //         return SizedBox(
  //           height: Get.height,
  //           child: DollarWalletHistory(
  //             transactionList: dollarTransactionList,
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}

class DollarWalletHistory extends StatefulWidget {
  List<NairaTransactionList> transactionList;
  ScrollController? controller;

  DollarWalletHistory(
      {super.key, required this.transactionList, this.controller});

  @override
  State<DollarWalletHistory> createState() => _DollarWalletHistoryState();
}

class _DollarWalletHistoryState extends State<DollarWalletHistory> {
  ScrollController? scrollController;

  @override
  void initState() {
    scrollController = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(10.h),
          Text(
            "RESULT",
            style: CustomTextStyle.kTxtBold.copyWith(
                color: AppColor.primary100,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
          Gap(10.h),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.only(top: 10.h),
                itemCount: widget.transactionList.length,
                itemBuilder: (context, index) {
                  NairaTransactionList element = widget.transactionList[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: DollarTransactionWidgetDesgin(
                      transactionList: element,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
