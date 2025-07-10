import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/bloc/product/product_bloc.dart';
import 'package:utilitypoint/model/request/topUpCard.dart';
import 'package:utilitypoint/utils/reuseableFunctions.dart';
import 'package:utilitypoint/view/home/home_screen.dart';
import 'package:utilitypoint/view/menuOption/cards/newCardDetailsSCreen.dart';
import 'package:utilitypoint/view/menuOption/cards/virtualCardScreens.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../../bloc/card/virtualcard_bloc.dart';
import '../../../model/request/getProduct.dart';
import '../../../model/request/getUserRequest.dart';
import '../../../model/request/unfreezeCard.dart';
import '../../../model/response/listofVirtualCard.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/height.dart';
import '../../../utils/reOccurringWidgets/transactionPin.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import '../convertFunds/convert.dart';
import 'CardDesign.dart';

class CardInformation extends StatefulWidget {
  UserVirtualCards? userVirtualCards;

  CardInformation({super.key, this.userVirtualCards});

  @override
  State<CardInformation> createState() => _CardInformationState();
}

class _CardInformationState extends State<CardInformation>
    with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  List<UserVirtualCards> userCards = [];
  late VirtualcardBloc bloc;
  late ProductBloc productBloc;
  bool isLoading = false;

  @override
  void initState() {
    print(widget.userVirtualCards?.freezeStatus);
    print("the freezzee");
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
    bloc = BlocProvider.of<VirtualcardBloc>(context);
    productBloc = BlocProvider.of<ProductBloc>(context);
    return BlocBuilder<VirtualcardBloc, VirtualcardState>(
      builder: (context, state) {
        if (state is VirtualcardError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, () {
              AppUtils.showSnack(
                  state.errorResponse.message ?? "Error occurred", context);
            });
          });
          bloc.initial();
        }
        if (state is AllUserVirtualCards) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            userCards = state.response;
            setState(() {
              isLoading = false;
            });
            for (var item in userCards) {
              if (item.cardId.contains(widget.userVirtualCards!.cardId)) {
                setState(() {
                  widget.userVirtualCards = item;
                });
              }
            }
          });
          bloc.initial();
        }
        if (state is  CardFreezeSuccessful) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              isLoading = true;
            });
            bloc.add(GetUserCardEvent(
                GetUserIdRequest(userId: loginResponse!.id)));
          });
          bloc.initial();
        }
        if (state is  CardUnFreezeSuccessful) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              isLoading = true;
            });
            bloc.add(GetUserCardEvent(
                GetUserIdRequest(userId: loginResponse!.id)));
          });
          bloc.initial();
        }
        if (state is SingleCardDetail) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              isLoading = false;
            });
            Get.to(NewCardInformation(userVirtualCards: widget.userVirtualCards,
            singeCardDetails:state.response
            ));
          });
          bloc.initial();
        }
        return OverlayLoaderWithAppIcon(
          isLoading: isLoading,
          overlayBackgroundColor: AppColor.black40,
          circularProgressColor: AppColor.primary100,
          appIconSize: 60.h,
          appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductError) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Future.delayed(Duration.zero, () {
                    AppUtils.showSnack(
                        state.errorResponse.message ?? "Error occurred",
                        context);
                  });
                });
                productBloc.initial();
              }

              return Scaffold(
                body: appBodyDesign(getBody(),context: context),
              );
            },
          ),
        );
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
                  height: 52.h, child: CustomAppBar(title: "Card Information")),
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

                    CardInfoDesign(cardDetail: widget.userVirtualCards),
                    Gap(51.h),

                   CustomButton(onTap: (){
                     setState(() {
                       isLoading =true;
                     });
                     bloc.add(GetSingleCardDetailsEvent(GetProductRequest(
                       userId: loginResponse!.id,
                       cardId: widget.userVirtualCards!.cardId
                     )));

                   }, buttonText: "Card Details",
                   textColor: AppColor.black0,
                     buttonColor: AppColor.primary100,
                     borderRadius: 8.r,
                     height: 58.h,
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

  navigations(int index) {
    switch (index) {
      case 0:
        return widget.userVirtualCards?.amount;
      case 1:
        return widget.userVirtualCards?.cardNumber;
      case 2:
        return widget.userVirtualCards?.cardExpiry;
      case 3:
        return widget.userVirtualCards?.cardCcv;
      case 4:
        return widget.userVirtualCards?.freezeStatus == "0"
            ? "Active"
            : "Inactive";
      // case 2: Get.to(()=>VirtualCards());
    }
  }

  Widget cardInfoButtons(
      {String title = "",
      String message = "",
      int index = 0,
      Function()? onChanged}) {
    return Container(
        height: 50.h,
        width: 335.w,
        margin: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 8, offset: Offset(0, 8)),
          ],
          color: AppColor.black0,
        ),
        padding: EdgeInsets.symmetric(horizontal: 9.5.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                title,
                style: CustomTextStyle.kTxtMedium.copyWith(
                    color: AppColor.black100,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
            card(index, message, onChanged)
          ],
        ));
  }

  Widget card(int index, String value, Function()? onTap) {
    switch (index) {
      case 0:
        return Text(
          NumberFormat.currency(symbol: '\$', decimalDigits: 0)
              .format(double.parse(value.toString())),
          style: GoogleFonts.inter(
              color: AppColor.primary100,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400),
        );
      case 4:
        return Text(
          value,
          style: GoogleFonts.inter(
              color: AppColor.black80,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400),
        );
      default:
        return GestureDetector(
          onTap: onTap,
          child: SizedBox(
            child: Row(
              children: [
                Text(
                  value,
                  style: GoogleFonts.inter(
                      color: AppColor.primary100,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                ),
                Gap(4.w),
                Image.asset(
                  "assets/image/icons/fi_copy.png",
                  height: 16.h,
                  width: 16.w,
                )
              ],
            ),
          ),
        );
    }
  }
}

class TopUpCardOption extends StatefulWidget {
  UserVirtualCards? userVirtualCards;

  TopUpCardOption({super.key, this.userVirtualCards});

  @override
  State<TopUpCardOption> createState() => _TopUpCardOptionState();
}

class _TopUpCardOptionState extends State<TopUpCardOption> {
  TextEditingController amountController = TextEditingController();
  bool isFromNaira = false;
  bool isTopUpFromDollarCard = true;
  TextEditingController amountController2 = TextEditingController();
  late VirtualcardBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<VirtualcardBloc>(context);
    return BlocBuilder<VirtualcardBloc, VirtualcardState>(
      builder: (context, state) {
        if (state is VirtualcardError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, () {
              AppUtils.showSnack(
                  state.errorResponse.message ?? "Error occurred", context);
            });
          });
          bloc.initial();
        }
        if (state is CardTopUpSuccessful) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.back(result: true);
            showSuccessSlidingModal(context,
                successMessage: "Card Successfully Topped up!");
          });
          bloc.initial();
        }

        return OverlayLoaderWithAppIcon(
          isLoading: state is VirtualcardIsLoading,
          overlayBackgroundColor: AppColor.black40,
          circularProgressColor: AppColor.primary100,
          appIconSize: 60.h,
          appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
          child: Scaffold(
            backgroundColor: AppColor.primary20,
            body: Container(
              height: 400.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(10.h),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isTopUpFromDollarCard = false;
                        isFromNaira = true;
                      });
                      // Get.to(ConvertScreen());
                    },
                    child: Container(
                      height: 70.h,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      margin: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isFromNaira
                                ? AppColor.primary100
                                : AppColor.black0),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 8)),
                        ],
                        color: AppColor.black0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Top up from Naira Wallet",
                              style: CustomTextStyle.kTxtBold.copyWith(
                                  color: AppColor.black100,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                                    symbol: nairaSymbol, decimalDigits: 2)
                                .format(double.parse(walletBalanceResponse!.nairaWallet)),
                            style: GoogleFonts.inter(
                                color: AppColor.primary100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isTopUpFromDollarCard = true;
                        isFromNaira = false;
                      });
                      // Get.to(ConvertScreen());
                    },
                    child: Container(
                      height: 70.h,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      margin: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                            color: !isFromNaira
                                ? AppColor.primary100
                                : AppColor.black0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 8)),
                        ],
                        color: AppColor.black0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Top up from Dollar Wallet",
                              style: CustomTextStyle.kTxtBold.copyWith(
                                  color: AppColor.black100,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                                    symbol: dollarSymbol, decimalDigits: 0)
                                .format(
                                    double.parse(walletBalanceResponse!.dollarWallet)),
                            style: GoogleFonts.inter(
                                color: AppColor.primary100,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                  Gap(14.h),
                  Text(
                    "Enter Amount",
                    style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                      height: 58.h,
                      child: CustomizedTextField(
                        onChanged: isFromNaira
                            ? (value) {
                                if (double.parse(value) >
                                    double.parse(userDetails!.nairaWallet)) {
                                  AppUtils.showSnack(
                                      "Insufficient Balance", context);
                                }
                              }
                            : (value) {
                                if (double.parse(value) >
                                    double.parse(userDetails!.dollarWallet)) {
                                  AppUtils.showSnack(
                                      "Insufficient Balance", context);
                                }
                              },
                        textEditingController:
                            isFromNaira ? amountController : amountController2,
                      )),
                  Gap(24.h),
                  CustomButton(
                    onTap: () async {
                      if (isFromNaira) {
                        if (amountController.text.isNotEmpty) {
                          Get.to(ConvertScreen(
                            cardId:widget.userVirtualCards!.cardId,
                            isTopUpCard: true,
                            amountToConvert: amountController.text,
                          ));
                        } else {
                          AppUtils.showSnack(
                              "Please enter an amount to fund your card",
                              context);
                        }
                      } else {
                        if (amountController2.text.isNotEmpty) {
                          List<dynamic> response =
                              await Get.to(TransactionPin());
                          if (response[0]) {
                            bloc.add(FundCardEvent(TopUpCardRequest(
                              userId: loginResponse!.id,
                              cardId: widget.userVirtualCards!.cardId,
                              amount: double.parse(amountController2.text),
                              pin: response[1],
                            )));
                          }
                        } else {
                          AppUtils.showSnack(
                              "Please enter an amount to fund your card",
                              context);
                        }
                      }
                    },
                    buttonText: "Fund Card",
                    textColor: AppColor.black0,
                    borderRadius: 10.r,
                    buttonColor: AppColor.primary100,
                    height: 48.h,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
