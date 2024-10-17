import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/model/request/getProduct.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/utils/image_paths.dart';
import 'package:utilitypoint/utils/text_style.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../bloc/card/virtualcard_bloc.dart';
import '../../bloc/product/product_bloc.dart';
import '../../model/response/airtimeDatatransactionHistory.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/app_util.dart';
import '../../utils/customAnimation.dart';
import '../../utils/reusable_widget_two.dart';
import '../../utils/reuseable_widget.dart';
List<ProductTransactionList> transactionList =[];
List<ProductTransactionList> tempTransactionList =[];
class TransactionScreen extends StatefulWidget {
   bool? isBottomNav;
  TransactionScreen({super.key, this.isBottomNav});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  bool isAll =true;
  bool isDataAirtime= false;
  bool isNairaTransactions= false;
  bool isDollarTransactions= false;
  late ProductBloc bloc;
  List<ProductTransactionList> transactionList =[];
  DateTime currentDateTime = DateTime.now();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      transactionList =tempTransactionList;
      if(tempTransactionList.isEmpty){
        bloc.add(GetProductTransactionHistoryEvent(GetProductRequest(
          userId: loginResponse!.id,
          dateFrom: "${currentDateTime.year}-${currentDateTime.month}-01",
          dateTo:"${currentDateTime.year}-${currentDateTime.month}-${_getLastDayOfTheMonth()}",
        )));
      }

    });
    super.initState();
    // Initialize the SlideAnimationManager
    _animationManager = SlideAnimationManager(this);
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
  void dispose() {
    // Dispose the animation manager to avoid memory leaks
    _animationManager.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bloc =BlocProvider.of<ProductBloc>(context);
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

    if(state is AirtimeDataTransactionHistorySuccess){
      WidgetsBinding.instance.addPostFrameCallback((_){
        transactionList=state.response;
        tempTransactionList = transactionList;
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
  getBody(){
    return SingleChildScrollView(
      child: Column(
        children: [
          SlideTransition(
            position: _animationManager.slideAnimationTop,
            child: Padding(
              padding:  EdgeInsets.only(top: 52.h,left: 20.w,bottom: 17.h),
              child: SizedBox(
                  height: 52.h,
                  child: CustomAppBar(title: "Transaction history",
                    isBottomNav: widget.isBottomNav,)
              ),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _animationManager.slideAnimation,
            child: Container(
              height: 668.72.h,
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 26.h,horizontal: 24.w),
              decoration: BoxDecoration(
                color: AppColor.primary20,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r),topRight: Radius.circular(30.r)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height:41.h,
                        child: Row(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: 260.w,
                                    height: 41.h,
                                    child: SearchTransactionHistory(
                                      hintTxt: "Search History",
                                      surffixWidget: Container(
                                          height:20.h ,
                                          width: 20.w,
                                          padding: EdgeInsets.all(8.h),
                                          child: Image.asset(search_Image,height: 14.h,width: 14.w,)),
                                    )),
                                Container(
                                  height: 41.h,
                                  width:41.w,
                                  padding: EdgeInsets.all(12.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(8.r),
                                    bottomRight: Radius.circular(8.r)),
                                    color: AppColor.primary100
                                  ),
                                  child: Image.asset(filter_Image,height: 18.h,width: 18.w,),
                                )
                              ],
                            ),
                            Gap(8.w),
                            Image.asset(download_Image,height: 18.h,width: 18.w,)
                          ],
                        ),
                    ),
                    Gap(24.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          filterDesign("All", isAll,(){
                            setState(() {
                              isAll=true;
                              isDataAirtime=false;
                              isNairaTransactions=false;
                              isDollarTransactions=false;
                            });
                          }),
                          Gap(8.w),
                          filterDesign("Data & Airtime", isDataAirtime,(){
                            setState(() {
                              isDataAirtime=true;
                              isAll=false;
                              isNairaTransactions=false;
                              isDollarTransactions=false;
                            });
                          }),
                          Gap(8.w),
                          filterDesign("Naira Transactions", isNairaTransactions,(){
                            setState(() {
                              isNairaTransactions=true;
                              isDataAirtime=false;
                              isAll=false;
                              isDollarTransactions=false;
                            });
                          }),
                          Gap(8.w),
                          filterDesign("Dollar Transactions", isDollarTransactions,(){
                            setState(() {
                              isDollarTransactions=true;
                              isDataAirtime=false;
                              isNairaTransactions=false;
                              isAll=false;
                            });
                          }),
                        ],
                      ),
                    ),
                    Gap(24.h),
                   ...transactionList.mapIndexed((element, index) =>
                   Padding(
                     padding:  EdgeInsets.only(bottom:12.h),
                     child: ProductTransactionWidgetDesgin(transactionList: element,),
                   )
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

  Widget filterDesign(String title,bool isSelected,Function()? onTap){
    return GestureDetector(
      onTap:onTap,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 12.5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: isSelected?AppColor.primary100:AppColor.black0,
          border: Border.all(color: isSelected?AppColor.primary100:AppColor.black100),
        ),
        child: Center(
          child: Text(title,
          style: CustomTextStyle.kTxtMedium.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: isSelected?AppColor.black0:AppColor.black100
          ),
          ),
        ),
      ),
    );
  }
}
