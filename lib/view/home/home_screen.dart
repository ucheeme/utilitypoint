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
import 'package:utilitypoint/model/response/userDetails.dart';
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
import '../../utils/reuseable_widget.dart';
import '../../utils/route.dart';
import '../fundWallet/fund_wallet.dart';
import 'airtimePurchase/productListScreen.dart';
import 'cable/cableListView.dart';
import 'dataPurchase/dataScreen.dart';
import 'electricity/electricityListView.dart';

List<NetworkList> appAllNetworkList = [];
List<UserGeneralSettings> appAllSettingsList = [];
List<Products> appAllProductList = [];
List<ProductTransactionList> airtimeDataTransactionHistory = [];
UserDetails? userDetails;

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentWallet = 0;
  late ProductBloc bloc;

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
    });
    super.initState();
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
              AppUtils.showSnack(
                  state.errorResponse.message ?? "Error occurred", context);
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
                                onTap: () {
                                  Get.to(
                                      FundWalletScreen(
                                        isFundDollarWallet: true,
                                      ),
                                      curve: Curves.easeIn);
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
                                onTap: () {}),
                            dashboardIcons(
                                title: "Convert",
                                icon: "convert",
                                onTap: () {
                                  Get.to(ConvertScreen(
                                    isTopUpCard: false,
                                    isCreateCard: false,
                                  ));
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
                                  Navigator.of(context)
                                      .push(createFlipRoute(Moreoptions()));
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(28.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Image.asset("assets/image/images_png/Card.png"),
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
