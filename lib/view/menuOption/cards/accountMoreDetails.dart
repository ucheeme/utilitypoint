import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/view/home/home_screen.dart';
import 'package:utilitypoint/view/menuOption/cards/virtualCardScreens.dart';

import '../../../bloc/card/virtualcard_bloc.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/height.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import '../../bottomsheet/createNewCard.dart';
import '../../transactionHistory/transaction.dart';
import 'cardTransactionHistory.dart';

class MyAccountMoreDetails extends StatefulWidget {
  bool isNaira = false;
  double accountBalance =0;
  String cardRef ="";
   MyAccountMoreDetails({super.key, required this.isNaira,required this.accountBalance,
   required this.cardRef});

  @override
  State<MyAccountMoreDetails> createState() => _MyAccountMoreDetailsState();
}

class _MyAccountMoreDetailsState extends State<MyAccountMoreDetails> with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
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
    bloc = BlocProvider.of<VirtualcardBloc>(context);
    return BlocBuilder<VirtualcardBloc, VirtualcardState>(
      builder: (context, state) {
        return OverlayLoaderWithAppIcon(
          isLoading: false,
          overlayBackgroundColor: AppColor.black40,
          circularProgressColor: AppColor.primary100,
          appIconSize: 60.h,
          appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
          child: Scaffold(
            body: appBodyDesign(getBody(),context: context),
          ),
        );
      },
    );
  }
  Widget getBody(){
    return SingleChildScrollView(
      child: Column(
        children: [
          SlideTransition(
            position: _animationManager.slideAnimationTop,
            child: Padding(
              padding:  EdgeInsets.only(top: 52.h,left: 20.w,bottom: 17.h),
              child: SizedBox(
                  height: 52.h,
                  child: CustomAppBar(title: "My Accounts")),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _animationManager.slideAnimation,
            child: Container(
              // height: 668.72.h,
              height: MediaQuery.of(context).size.height,
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: cardDesign(
                          accountBalance:double.parse(userDetails!.dollarWallet),
                          balanceRemaining: 0.00,
                          cardNumber: widget.cardRef,
                          isNaira:widget.isNaira
                      ),
                    ),
                    height8,
                    // convertContainer(isSelected: true),
                    // bloc.validation.userCards.isEmpty?
                    //     Column(
                    //       children: [
                    //         Image.asset("assets/image/images_png/empty.png"),
                    //         Text("You Have No Card!",style: CustomTextStyle.kTxtBold.copyWith(
                    //           color: AppColor.black100,
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 16.sp
                    //         ),)
                    //       ],
                    //     ):
                    SizedBox(
                      height: 400.h,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: bloc.validation.accountInfo.length,
                          itemBuilder:(context,index){
                            String item= bloc.validation.accountInfo[index];
                            return Column(
                              children: [
                                GestureDetector(
                                    onTap: (){
                                      navigations(index);
                                    },
                                    child: listButtons(title: item,icons:"")),
                              ],
                            );
                          }),
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
  navigations(int index){
    switch(index){
      case 0: Get.to(()=>AllCards());
      case 1: Get.to(()=>VirtualCards(isNaira: widget.isNaira,));
     // case 2: Get.to(()=>VirtualCards());
    }
  }
}
