import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
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
import 'package:utilitypoint/model/response/nairaDollarTransactionList.dart';
import 'package:utilitypoint/utils/reusable_widget_two.dart';
import 'package:utilitypoint/utils/reuseableFunctions.dart';
import 'package:utilitypoint/view/home/home_screen.dart';
import 'package:utilitypoint/view/menuOption/cards/virtualCardScreens.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../../bloc/card/virtualcard_bloc.dart';
import '../../../model/request/getProduct.dart';
import '../../../model/request/getUserRequest.dart';
import '../../../model/request/unfreezeCard.dart';
import '../../../model/response/airtimeDatatransactionHistory.dart';
import '../../../model/response/cardTransactions.dart';
import '../../../model/response/listofVirtualCard.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/height.dart';
import '../../../utils/reOccurringWidgets/transactionPin.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import '../convertFunds/convert.dart';
import '../notifications.dart';
import 'CardDesign.dart';

class NewCardInformation extends StatefulWidget {
  UserVirtualCards? userVirtualCards;

  NewCardInformation({super.key, this.userVirtualCards});

  @override
  State<NewCardInformation> createState() => _NewCardInformationState();
}

class _NewCardInformationState extends State<NewCardInformation>
    with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  List<UserVirtualCards> userCards = [];
  late VirtualcardBloc bloc;
  late ProductBloc productBloc;
  bool isLoading = false;
  final con = GestureFlipCardController();
  DateTime currentDateTime = DateTime.now();
  List<NairaTransactionList> transactionList =[];
  @override
  void initState() {
  WidgetsBinding.instance.addPostFrameCallback((_){
    setState(() {
      isLoading=true;
    });
    bloc.add(GetCardTransactionHistoryEvent(GetProductRequest(
        userId: loginResponse!.id,
        cardId:widget.userVirtualCards?.cardId,
        startDate: "${currentDateTime.year}-${currentDateTime.month}-01",
        endDate: "${currentDateTime.year}-${currentDateTime.month}-${_getLastDayOfTheMonth()}",
        pageSize: 40.toString(),
        page: 1.toString()
    )));
  });
    super.initState();
    // Initialize the SlideAnimationManager
    _animationManager = SlideAnimationManager(this);
  }
  List<CardTransactionList>cardTransactionList =[];
  @override
  void dispose() {
    // Dispose the animation manager to avoid memory leaks
    _animationManager.dispose();
    super.dispose();
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
        if (state is AllCardTransactions) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            cardTransactionList=state.response.details.transactions;
            setState(() {
              isLoading= false;
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
                  setState(() {
                    isLoading=false;
                  });
                  Future.delayed(Duration.zero, () {
                    AppUtils.showSnack(
                        state.errorResponse.message ?? "Error occurred",
                        context);
                  });
                });
                productBloc.initial();
              }
              if (state is AllUserDetails) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  userDetails = state.response;
                  setState(() {
                    isLoading = false;
                  });
                  bool? response = await showCupertinoModalBottomSheet(
                      topRadius: Radius.circular(20.r),
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (context) {
                        return Container(
                            height: 400.h,
                            color: AppColor.primary20,
                            child: TopUpCardOption(
                              userVirtualCards: widget.userVirtualCards,
                            ));
                      });
                  if (response == true) {
                    setState(() {
                      isLoading = true;
                    });
                    bloc.add(GetUserCardEvent(
                        GetUserIdRequest(userId: loginResponse!.id)));
                  }
                });
                productBloc.initial();
              }
              if(state is AllDollarTransactions){
                WidgetsBinding.instance.addPostFrameCallback((_){
                    transactionList=state.response;
                    setState(() {
                      isLoading=false;
                    });
                });
                bloc.initial();
              }
              return Scaffold(
                body: appBodyDesign(getBody()),
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
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        productBloc.add(GetUserDetails(
                            GetProductRequest(userId: loginResponse!.id)));
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 30.h,
                          width: 90.w,
                          //padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 22.w),
                          decoration: BoxDecoration(
                              color: AppColor.primary100,
                              borderRadius: BorderRadius.circular(8.r)
                          ),
                          child: Center(
                            child: Text(
                              "Top Up Card",
                              style: CustomTextStyle.kTxtBold.copyWith(
                                  color: AppColor.black0,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                GestureFlipCard(
                animationDuration: const Duration(milliseconds: 300),
                axis: FlipAxis.horizontal,
                controller:con, // used to ccontrol the Gesture flip programmatically
                enableController : false ,// if [True] if you need flip the card using programmatically
              frontWidget:  CardInfoDesign(cardDetail: widget.userVirtualCards),
            backWidget:  Container(
              margin: EdgeInsets.only(top: 20.h),
                height: 164.h,
                child: CardBackView(cardDetail: widget.userVirtualCards)),
          ),

                    Gap(24.h),

                    Gap(24.h),
                    GestureDetector(
                      onTap: () async {
                        List response = await Get.to(() => TransactionPin());
                        if( widget.userVirtualCards?.freezeStatus == "0"){
                          if (response[0]) {
                            setState(() {
                              isLoading= true;
                            });
                            bloc.add(FreezeCardEvent(FreezeUnfreezeCard(
                                userId: loginResponse!.id,
                                cardId: widget.userVirtualCards!.cardId,
                                pin: response[1])));
                          }
                        }else{
                          if (response[0]) {
                            setState(() {
                              isLoading= true;
                            });
                            bloc.add(UnFreezeCardEvent(FreezeUnfreezeCard(
                                userId: loginResponse!.id,
                                cardId: widget.userVirtualCards!.cardId,
                                pin: response[1])));
                          }

                        }

                      },
                      child: Container(
                        height: 46.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        margin: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.primary100),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 8)),
                          ],
                          color: AppColor.black0,
                        ),
                        child: Center(
                          child: Text(
                            widget.userVirtualCards?.freezeStatus == "0"
                                ? "Lock Card"
                                : "Unlock Card",
                            style: CustomTextStyle.kTxtBold.copyWith(
                                color: AppColor.primary100,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),

                    Gap(12.h),
                    Container(
                      height: 276.h,
                      width: 335.w,
                      padding: EdgeInsets.symmetric(horizontal: 13.w),
                      decoration: BoxDecoration(
                        color: AppColor.black20.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8.r)
                      ),
                      child: cardTransactionList.isEmpty?
                      EmptyInfo(body: 'You have not carried out any transaction!',): Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(12.h),
                          Text("Transaction History",
                            style: CustomTextStyle.kTxtMedium.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w800,
                              fontSize: 14.sp
                            ),
                          ),
                          SizedBox(
                            height:220.h,
                            child: ListView.builder(
                              padding: EdgeInsets.only(top: 10.h),
                              itemCount: cardTransactionList.length,
                                itemBuilder: (context, index){
                                return Padding(
                                  padding:  EdgeInsets.only(bottom: 14.h),
                                  child: CardTransactionWidgetDesign(transactionList: cardTransactionList[index]),
                                );
                            }),
                          ),
                        ],
                      ),
                    )
                    // SizedBox(
                    //   height: 400.h,
                    //   child: ListView.builder(
                    //       padding: EdgeInsets.zero,
                    //       itemCount: bloc.validation.cardInformation.length,
                    //       itemBuilder: (context, index) {
                    //         String item =
                    //         bloc.validation.cardInformation[index];
                    //         return Column(
                    //           children: [
                    //             GestureDetector(
                    //                 onTap: () {
                    //                   navigations(index);
                    //                 },
                    //                 child: cardInfoButtons(
                    //                     title: item,
                    //                     message: navigations(index),
                    //                     index: index,
                    //                     onChanged: () {
                    //                       copyToClipboard(
                    //                           context, navigations(index));
                    //                     })),
                    //           ],
                    //         );
                    //       }),
                    // )
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
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: AppColor.primary20,
              body: Container(
                height: 400.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: SingleChildScrollView(
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
                                    .format(double.parse(userDetails!.nairaWallet)),
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
                                    double.parse(userDetails!.dollarWallet)),
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
            ),
          ),
        );
      },
    );
  }
}
