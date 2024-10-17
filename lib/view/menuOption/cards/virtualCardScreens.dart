import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/model/request/unfreezeCard.dart';
import 'package:utilitypoint/view/menuOption/cards/CardDesign.dart';

import '../../../bloc/card/virtualcard_bloc.dart';
import '../../../model/request/getUserRequest.dart';
import '../../../model/response/listofVirtualCard.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/height.dart';
import '../../../utils/reOccurringWidgets/transactionPin.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import '../../bottomsheet/createNewCard.dart';
import '../../onboarding_screen/signIn/login_screen.dart';
import 'cardTransactionHistory.dart';

class VirtualCards extends StatefulWidget {
  bool isNaira = true;
   VirtualCards({super.key, required this.isNaira});

  @override
  State<VirtualCards> createState() => _VirtualCardsState();
}

class _VirtualCardsState extends State<VirtualCards> with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  List<UserVirtualCards>userCards =[];
  late VirtualcardBloc bloc;
  bool isFreezed = false;
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
        if (state is CardFreezeSuccessful){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            bloc.add(GetUserCardEvent(GetUserIdRequest(userId: loginResponse!.id)));
           AppUtils.showSuccessSnack("Card Freezed Successfully!", context);

          });
          bloc.initial();
        }
        if (state is CardUnFreezeSuccessful){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            bloc.add(GetUserCardEvent(GetUserIdRequest(userId: loginResponse!.id)));
            AppUtils.showSuccessSnack("Card UnFreezed Successfully!", context);
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
            body: appBodyDesign(getBody()),
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
                  child: CustomAppBar(title: "Virtual card")),
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
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 550.h,
                      child:userCards.isEmpty?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/image/images_png/empty.png",
                            height: 40.h,
                            width: 60.w,
                          ),
                          Text(
                            "You do not have any card yet",
                            style: CustomTextStyle.kTxtBold.copyWith(
                                color: AppColor.black100,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp),
                          ),
                          SizedBox(
                            height: 49.h,
                            width: 269.w,
                            child: Text(
                              textAlign: TextAlign.center,
                              " Click on the button below to create new card",
                              style: CustomTextStyle.kTxtMedium.copyWith(
                                  color: AppColor.black80,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp),),
                          )
                        ],
                      ):
                      ListView.builder(
                        padding: EdgeInsets.zero,
                          itemCount:userCards.length,
                          itemBuilder: (context,index){
                        return Slidable(
                            endActionPane:  ActionPane(motion: StretchMotion(),
                                children: [
                                  Gap(20),
                                  GestureDetector(
                                    onTap: () async {
                                      List response = await Get.to(() => TransactionPin());
                                      if(response[0]){
                                        bloc.add(FreezeCardEvent(FreezeUnfreezeCard(
                                            userId: loginResponse!.id,
                                            cardId: userCards[index].cardId,
                                            pin: response[1]
                                        )));
                                      }
                                    },
                                    child: Container(
                                      height: 40.h,
                                      width: 40.w,
                                     padding: EdgeInsets.all(8.h),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4.r),
                                          color: AppColor.primary40
                                      ),
                                      child:Image.asset("assets/image/icons/freeze_Icon.png") ,
                                    ),
                                  ),
                                  Gap(10.w),
                                  GestureDetector(
                                    onTap: () async {
                                      List response = await Get.to(() => TransactionPin());
                                      if(response[0]){
                                        bloc.add(UnFreezeCardEvent(FreezeUnfreezeCard(
                                          userId: loginResponse!.id,
                                          cardId: userCards[index].cardId,
                                          pin: response[1]
                                        )));
                                      }
                                    },
                                    child: Container(
                                      height: 40.h,
                                      width: 40.w,
                                      padding: EdgeInsets.all(8.h),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4.r),
                                          color: AppColor.primary100
                                      ),
                                      child:Image.asset("assets/image/icons/unfreeze_Icon.png") ,
                                    ),
                                  )
                                ]),
                            child: CardDesign(cardDetail:userCards[index]));
                      }) ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(onTap: () async {
                    bool response=  await showCupertinoModalBottomSheet(
                                topRadius:
                                Radius.circular(10.r),
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (context) {
                                  return
                                    Container(
                                        height: 500.h,
                                        color: AppColor.primary20,
                                        child:  CreateNewCardScreen(bloc: bloc,isNaira:widget.isNaira)
                                    );
                                });
                    if(response){
                      showSuccessSlidingModal(
                          context,
                          successMessage: "Your Dollar Debit card was created and funded successfully!");
                    }
                    },
                      buttonText: "Create New Card",
                      buttonColor: AppColor.primary100,
                      textColor: AppColor.black0,
                      borderRadius:8.r,
                      height: 58.h,
                      icon: Icons.add_circle_outline,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


class AllCards extends StatefulWidget {
  const AllCards({super.key});

  @override
  State<AllCards> createState() => _AllCardsState();
}

class _AllCardsState extends State<AllCards> with TickerProviderStateMixin {
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
          isLoading: state is VirtualcardIsLoading,
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
                  child: CustomAppBar(title: "Select card")),
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
              child: SizedBox(
                  height: 500.h,
                  child:userCards.isEmpty?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/image/images_png/empty.png",
                        height: 40.h,
                        width: 60.w,
                      ),
                      Text(
                        "You do not have any card yet",
                        style: CustomTextStyle.kTxtBold.copyWith(
                            color: AppColor.black100,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp),
                      ),
                      SizedBox(
                        height: 49.h,
                        width: 269.w,
                        child: Text(
                          textAlign: TextAlign.center,
                          " You need to create a card to see transactions on it",
                          style: CustomTextStyle.kTxtMedium.copyWith(
                              color: AppColor.black80,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp),),
                      )
                    ],
                  ):
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount:userCards.length,
                      itemBuilder: (context,index){
                        return GestureDetector(
                            onTap: (){
                              Get.to(()=>CardTransactionHistory(cardId: userCards[index].cardId,));
                            },
                            child: CardDesign(cardDetail:userCards[index],isVirtualCardScreen: true,));
                      }) ),
            ),
          )
        ],
      ),
    );
  }
}



