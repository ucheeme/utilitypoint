import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:utilitypoint/utils/image_paths.dart';
import 'package:utilitypoint/utils/text_style.dart';

import '../../bloc/card/virtualcard_bloc.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/customAnimation.dart';
import '../../utils/reuseable_widget.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  bool isAll =true;
  bool isDataAirtime= false;
  bool isNairaTransactions= false;
  bool isDollarTransactions= false;
  late VirtualcardBloc bloc;
  @override
  void initState() {
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
    return Scaffold(
      body: appBodyDesign(getBody()),
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
                  child: CustomAppBar(title: "Transaction history")),
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
