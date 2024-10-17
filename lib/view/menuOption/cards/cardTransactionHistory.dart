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
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../../bloc/card/virtualcard_bloc.dart';
import '../../../model/response/cardTransactions.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/image_paths.dart';
import '../../../utils/reusable_widget_two.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
List<CardTransactionList>tempTransactionList =[];
class CardTransactionHistory extends StatefulWidget {
  String cardId="";
   CardTransactionHistory({super.key, required this.cardId});

  @override
  State<CardTransactionHistory> createState() => _CardTransactionHistoryState();
}

class _CardTransactionHistoryState extends State<CardTransactionHistory>with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  List<CardTransactionList>cardTransactionList =[];
  late VirtualcardBloc bloc;
  DateTime currentDateTime = DateTime.now();


  @override
  void initState() {
  //  cardTransactionList = tempTransactionList;
    WidgetsBinding.instance.addPostFrameCallback((_){
      bloc.add(GetCardTransactionHistoryEvent(GetProductRequest(
          userId: loginResponse!.id,
          cardId:widget.cardId,
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

        if (state is AllCardTransactions) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            for(var item in state.response.details.transactions){
              cardTransactionList.add(item);
            }
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
        body: appBodyDesign(getBody(state)),
      ),
    );
  },
);
  }
  getBody(VirtualcardState state){
    return SingleChildScrollView(
      child: Column(
        children: [
          SlideTransition(
            position: _animationManager.slideAnimationTop,
            child: Padding(
              padding:  EdgeInsets.only(top: 52.h,left: 20.w,bottom: 17.h),
              child: SizedBox(
                  height: 52.h,
                  child: CustomAppBar(title: "Card Transaction history")),
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
                              GestureDetector(
                                onTap: () async {
                                  // StartDateEndDate? result =await showModalBottomSheet(
                                  //     isDismissible: true,
                                  //     isScrollControlled: true,
                                  //     context: context,
                                  //     backgroundColor:AppColor.black10,
                                  //     shape:RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.only(topRight: Radius.circular(24.r),topLeft: Radius.circular(24.r)),
                                  //     ),
                                  //     builder: (context) => Padding(
                                  //       padding: EdgeInsets.only(
                                  //           bottom: MediaQuery.of(context).viewInsets.bottom),
                                  //       child:  CustomDateRangePicker(),
                                  //     )
                                  // );
                                  // if (result != null){
                                  //  // completionHandler(result);
                                  //   AppUtils.debug("start Date ${result.startDate}");
                                  //   AppUtils.debug("End Date ${result.endDate}");
                                  // }
                                },
                                child: Container(
                                  height: 41.h,
                                  width:41.w,
                                  padding: EdgeInsets.all(12.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(8.r),
                                          bottomRight: Radius.circular(8.r)),
                                      color: AppColor.primary100
                                  ),
                                  child: Image.asset(filter_Image,height: 18.h,width: 18.w,),
                                ),
                              )
                            ],
                          ),
                          Gap(8.w),
                          Image.asset(download_Image,height: 18.h,width: 18.w,)
                        ],
                      ),
                    ),
                    Gap(24.h),
                    ...cardTransactionList.mapIndexed((_element,index)=>
                       Padding(
                         padding:  EdgeInsets.only(bottom: 15.h),
                         child: CardTransactionWidgetDesign(transactionList: _element,),
                       )),
                    // Visibility(
                    //     visible: state is VirtualcardIsLoading,
                    //     child: SizedBox(
                    //   height: 100.h,
                    //   child: Center(
                    //     child: CircularProgressIndicator(color: AppColor.primary100,
                    //     backgroundColor: AppColor.primary40,),
                    //   ),
                    // ))
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
