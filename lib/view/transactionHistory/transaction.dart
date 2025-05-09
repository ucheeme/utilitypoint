import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/model/request/getProduct.dart';
import 'package:utilitypoint/model/response/nairaDollarTransactionList.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/utils/image_paths.dart';
import 'package:utilitypoint/utils/text_style.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';
import 'package:utilitypoint/view/transactionHistory/transactionReceipt.dart';

import '../../bloc/card/virtualcard_bloc.dart';
import '../../bloc/product/product_bloc.dart';
import '../../model/response/airtimeDatatransactionHistory.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/app_util.dart';
import '../../utils/customAnimation.dart';
import '../../utils/reusable_widget_two.dart';
import '../../utils/reuseable_widget.dart';
import '../home/home_screen.dart';
import '../menuOption/notifications.dart';

List<UserTransactions> tempUserTransactionList = [];
List<ProductTransactionList> tempTransactionList = [];

class TransactionScreen extends StatefulWidget {
  bool? isBottomNav;

  TransactionScreen({super.key, this.isBottomNav});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  bool isAll = true;
  bool isDataAirtime = false;
  bool isNairaTransactions = false;
  bool isDollarTransactions = false;
  late ProductBloc bloc;
  List<ProductTransactionList> transactionList = [];
  List<ProductTransactionList> nairaTransactionList = [];
  List<ProductTransactionList> dollarTransactionList = [];
  TextEditingController searchController = TextEditingController();
  DateTime currentDateTime = DateTime.now();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(GetProductTransactionHistoryEvent(GetProductRequest(
        userId: loginResponse!.id,
        dateFrom: "${currentDateTime.year}-${currentDateTime.month}-01",
        dateTo:
            "${currentDateTime.year}-${currentDateTime.month}-${_getLastDayOfTheMonth()}",
      )));
      //}
      setState(() {
        isHomePageWallet=false;
      });
    });
    super.initState();
    // Initialize the SlideAnimationManager
    _animationManager = SlideAnimationManager(this);
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

  @override
  void dispose() {
    // Dispose the animation manager to avoid memory leaks
    _animationManager.dispose();
    super.dispose();
  }

  void searchList(String value) {
    if (value.isEmpty) {
      setState(() {
        transactionList = tempTransactionList;
      });
      return;
    }

    String query = value.toLowerCase();

    setState(() {
      transactionList = tempTransactionList.where((element) {
        AppUtils.debug("Searching in: ${element.description}, ${element.metreNumber}, ${element.phoneNumber}, ${element.smartCardNumber}");

        return _containsQuery(element.metreNumber, query) ||
            _containsQuery(element.phoneNumber, query) ||
            _containsQuery(element.smartCardNumber, query) ||
            _containsQuery(element.description, query);
      }).toList();
    });
  }

  bool _containsQuery(String? field, String query) {
    return field != null && field.toLowerCase().contains(query);
  }


  @override
  Widget build(BuildContext context) {
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

        if (state is AirtimeDataTransactionHistorySuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            tempAllTransactionList = state.response;
            for (var item in state.response) {
              transactionList.add(item);
            }
            // transactionList=state.response;
            tempTransactionList = state.response;
            dollarTransactionList = tempTransactionList.where((element)=>element.walletCategory.toLowerCase()=="dollar_wallet").toList();
            nairaTransactionList = tempTransactionList.where((element)=>element.walletCategory.toLowerCase()=="naira_wallet").toList();
            // tempUserTransactionList = transactionList;
            // bloc.add(GetAllNairaWalletTransactionsEvent(GetProductRequest(
            //   userId: loginResponse!.id,
            //   startDate: "${currentDateTime.year}-${currentDateTime.month}-01",
            //   endDate:
            //       "${currentDateTime.year}-${currentDateTime.month}-${_getLastDayOfTheMonth()}",
            // )));
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
            body: appBodyDesign(getBody()),
          ),
        );
      },
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SlideTransition(
            position: _animationManager.slideAnimationTop,
            child: Padding(
              padding: EdgeInsets.only(top: 52.h, left: 20.w, bottom: 17.h),
              child: SizedBox(
                  height: 52.h,
                  child: CustomAppBar(
                    title: "Transaction history",
                    isBottomNav: widget.isBottomNav,
                  )),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _animationManager.slideAnimation,
            child: Container(
              height: 668.72.h,
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 14.w),
              decoration: BoxDecoration(
                color: AppColor.primary20,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 41.h,
                      child: Row(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: 260.w,
                                  height: 41.h,
                                  child: SearchTransactionHistory(
                                    textEditingController: searchController,
                                    onChanged: searchList,
                                    hintTxt: "Search History",
                                    surffixWidget: Container(
                                        height: 20.h,
                                        width: 20.w,
                                        padding: EdgeInsets.all(8.h),
                                        child: Image.asset(
                                          search_Image,
                                          height: 14.h,
                                          width: 14.w,
                                        )),
                                  )),
                              GestureDetector(
                                onTap: () async {
                                  _showDateRangePicker();
                                },
                                child: Container(
                                  height: 41.h,
                                  width: 41.w,
                                  padding: EdgeInsets.all(12.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8.r),
                                          bottomRight: Radius.circular(8.r)),
                                      color: AppColor.primary100),
                                  child: Image.asset(
                                    filter_Image,
                                    height: 18.h,
                                    width: 18.w,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Gap(8.w),
                          Image.asset(
                            download_Image,
                            height: 18.h,
                            width: 18.w,
                          )
                        ],
                      ),
                    ),
                    Gap(24.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          filterDesign("All", isAll, () {
                            setState(() {
                              isAll = true;
                              isDataAirtime = false;
                              isNairaTransactions = false;
                              isDollarTransactions = false;
                              transactionList = tempTransactionList;
                              selectionChoice = 0;
                            });
                          }),
                          Gap(8.w),
                          filterDesign("Data & Airtime", isDataAirtime, () {
                            transactionList = tempTransactionList
                                .where((element) => (element.description
                                        .toLowerCase()
                                        .contains("airtime") ||
                                    element.description
                                        .toLowerCase()
                                        .contains("data")))
                                .toList();
                            setState(() {
                              isDataAirtime = true;
                              isAll = false;
                              isNairaTransactions = false;
                              isDollarTransactions = false;
                              transactionList = transactionList;
                              selectionChoice = 0;
                            });
                          }),
                          Gap(8.w),
                          filterDesign(
                              "Naira Transactions", isNairaTransactions, () {
                            setState(() {
                              isNairaTransactions = true;
                              isDataAirtime = false;
                              isAll = false;
                              isDollarTransactions = false;
                              selectionChoice = 1;
                              // transactionList= tempUserTransactionList.where((element)=>element.isProduct==false && element.walletCategory=="dollar_wallet").toList();
                            });
                            // bloc.add(GetAllNairaWalletTransactionsEvent(GetProductRequest(
                            //   userId: loginResponse!.id,
                            //   startDate: "${currentDateTime.year}-${currentDateTime.month}-01",
                            //   endDate:"${currentDateTime.year}-${currentDateTime.month}-${_getLastDayOfTheMonth()}",
                            // )));
                          }),
                          Gap(8.w),
                          filterDesign(
                              "Dollar Transactions", isDollarTransactions, () {
                            setState(() {
                              isDollarTransactions = true;
                              isDataAirtime = false;
                              isNairaTransactions = false;
                              isAll = false;
                              selectionChoice = 2;
                              // transactionList= tempUserTransactionList.where((element)=>element.isProduct==false && element.walletCategory=="dollar_wallet").toList();
                            });
                          }),
                        ],
                      ),
                    ),
                    Gap(24.h),
                    SizedBox(
                        height: 500.h,
                        child: getOption()
                            ? EmptyInfo(
                                body:
                                    'You have not carried out any transaction!',
                              )
                            : getWidget(selectionChoice)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  int selectionChoice = 0;
  bool getOption(){
    if(transactionList.isEmpty&&selectionChoice==0){
      return true;
    }else if((nairaTransactionList.isEmpty&&selectionChoice==1)){
      return true;
    }else if(dollarTransactionList.isEmpty&&selectionChoice==2){
      return true;
    }else{
      return false;
    }
  }
  Widget getWidget(int selectionChoice) {
    if (selectionChoice == 1) {
      return ListView.builder(
          padding: EdgeInsets.only(top: 10.h),
          itemCount: nairaTransactionList.length,
          itemBuilder: (context, index) {
            ProductTransactionList element = nairaTransactionList[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: GestureDetector(
                  onTap: () {
                    print("Transaction List: $element");
                    Get.to(TransactionReceiptScreen(
                      productTransactionList: element,
                    ));
                  },
                  child: NairaTransactionWidgetDesgin(
                   transactionList : element,
                  )),
            );
          });
    } else if (selectionChoice == 2) {
      return ListView.builder(
          padding: EdgeInsets.only(top: 10.h),
          itemCount: dollarTransactionList.length,
          itemBuilder: (context, index) {
            ProductTransactionList element = dollarTransactionList[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: GestureDetector(
                  onTap: () {
                    print("Transaction List: $element");
                    Get.to(TransactionReceiptScreen(
                      productTransactionList: element,
                    ));
                  },
                  child: NairaTransactionWidgetDesgin(
                    transactionList: element,
                  )),
            );
          });
    } else {
      return ListView.builder(
          padding: EdgeInsets.only(top: 10.h),
          itemCount: transactionList.length,
          itemBuilder: (context, index) {
            ProductTransactionList element = transactionList[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: GestureDetector(
                  onTap: () {
                    print("Transaction List: $element");
                    Get.to(TransactionReceiptScreen(
                      productTransactionList: element,
                    ));
                  },
                  child: NairaTransactionWidgetDesgin(
                    transactionList: element,
                  )),
            );
          });
    }
  }

  Widget filterDesign(String title, bool isSelected, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: isSelected ? AppColor.primary100 : AppColor.black0,
          border: Border.all(
              color: isSelected ? AppColor.primary100 : AppColor.black100),
        ),
        child: Center(
          child: Text(
            title,
            style: CustomTextStyle.kTxtMedium.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: isSelected ? AppColor.black0 : AppColor.black100),
          ),
        ),
      ),
    );
  }
  Future<void> _showDateRangePicker() async {
    StartDateEndDate? result = await showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: AppColor.primary20,
      topRadius: Radius.circular(20.r),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) => SizedBox(
        height: 400.h,
        child: CustomDateRangePicker(),
      ),
    );

    if (result != null) {
      _filterTransactions(result);
    }
  }

  void _filterTransactions(StartDateEndDate result) {
    DateTime startDate = DateTime.parse(result.startDate);
    DateTime endDate = DateTime.parse(result.endDate);

    AppUtils.debug("Start Date: $startDate");
    AppUtils.debug("End Date: $endDate");

    setState(() {
      transactionList = tempAllTransactionList.where((item) {
        DateTime itemDate = item.createdAt;
        return itemDate.isAfter(startDate.subtract(Duration(days: 1))) &&
            itemDate.isBefore(endDate.add(Duration(days: 1)));
      }).toList();
    });
  }

}
