import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/model/request/getUserRequest.dart';
import 'package:utilitypoint/utils/reuseable_widget.dart';
import 'package:utilitypoint/view/bottomsheet/createNewCard.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../../bloc/card/virtualcard_bloc.dart';
import '../../../model/response/listofVirtualCard.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/height.dart';
import '../../../utils/reuseableFunctions.dart';
import '../../../utils/text_style.dart';
import 'accountMoreDetails.dart';

class Cardscreen extends StatefulWidget {
  const Cardscreen({super.key});

  @override
  State<Cardscreen> createState() => _CardscreenState();
}

class _CardscreenState extends State<Cardscreen> with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  List<UserVirtualCards>userCards =[];
  late VirtualcardBloc bloc;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      bloc.add(GetUserCardEvent(GetUserIdRequest(userId: loginResponse!.id)));
    });
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
    if (state is VirtualcardError){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, (){
          AppUtils.showSnack(state.errorResponse.message ?? "Error occurred", context);
        });
      });
      bloc.initial();
    }
    if (state is AllUserVirtualCards){
      WidgetsBinding.instance.addPostFrameCallback((_) {
       userCards = state.response;
      });
      bloc.initial();
    }

    return OverlayLoaderWithAppIcon(
      isLoading: false,
      overlayBackgroundColor: AppColor.black40,
      circularProgressColor: AppColor.primary100,
      appIconSize: 60.h,
      appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
      child: Scaffold(
        body: appBodyDesign(getBody(context)),
      ),
    );
  },
);
  }
  Widget getBody(context){
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
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: () async {
                    //       await showCupertinoModalBottomSheet(
                    //       topRadius:
                    //       Radius.circular(10.r),
                    //       backgroundColor: Colors.white,
                    //       context: context,
                    //       builder: (context) {
                    //         return
                    //           Container(
                    //               height: 500.h,
                    //               color: AppColor.primary20,
                    //               child:  CreateNewCardScreen(bloc: bloc,)
                    //           );
                    //       });
                    //     },
                    //     child: Text("Create New Cards", style: CustomTextStyle.kTxtBold.copyWith(
                    //         color: AppColor.primary100,
                    //         fontWeight: FontWeight.w400,
                    //         fontSize: 14.sp
                    //     ),),
                    //   ),
                    // ),
                    // height8,
                    // bloc.validation.userCards.isEmpty?
                    //     SizedBox(
                    //       height: 400.h,
                    //       width: Get.width,
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Image.asset("assets/image/images_png/empty.png",height: 40.h,width: 60.w,),
                    //           Text("You Have No Card!",style: CustomTextStyle.kTxtBold.copyWith(
                    //             color: AppColor.black100,
                    //             fontWeight: FontWeight.w600,
                    //             fontSize: 16.sp
                    //           ),)
                    //         ],
                    //       ),
                    //     ):
                        SizedBox(
                          height: 400.h,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: 2,
                              itemBuilder:(cntxt,index){
                                String cardRef =generateRandomNumberString(9);
                            return cardDesign(
                                accountBalance: double.parse(index==0?loginResponse!.nairaWallet:loginResponse!.dollarWallet),
                                balanceRemaining: 0.00,
                            cardNumber:cardRef ,
                              cardCTA: (){
                                Get.to( MyAccountMoreDetails(
                                  isNaira: index==1?false:true,
                                  accountBalance:double.parse(index==0?loginResponse!.nairaWallet:loginResponse!.dollarWallet),
                                  cardRef: cardRef,
                                ),curve: Curves.easeIn);
                              },
                              copyCTA: (){
                                //copyToClipboard(cntxt,"");
                              },
                              isNaira: index==1?false:true
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
}
