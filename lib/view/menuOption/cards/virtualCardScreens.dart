import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/view/menuOption/cards/CardDesign.dart';

import '../../../bloc/card/virtualcard_bloc.dart';
import '../../../model/request/getUserRequest.dart';
import '../../../model/response/listofVirtualCard.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/height.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import '../../bottomsheet/createNewCard.dart';
import '../../onboarding_screen/signIn/login_screen.dart';

class VirtualCards extends StatefulWidget {
  const VirtualCards({super.key});

  @override
  State<VirtualCards> createState() => _VirtualCardsState();
}

class _VirtualCardsState extends State<VirtualCards> with TickerProviderStateMixin {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 500.h,
                      child:ListView.builder(
                        padding: EdgeInsets.zero,
                          itemCount:userCards.length,
                          itemBuilder: (context,index){
                        return CardDesign(cardDetail:userCards[index]);
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
                                        child:  CreateNewCardScreen(bloc: bloc,)
                                    );
                                });
                    if(response){
                      showSuccessSlidingModal(
                          context,
                          successMessage: "Your Dollar Debit card was created and funded successfully!");
                    }
                    },
                      buttonText: "Add New Card",
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
