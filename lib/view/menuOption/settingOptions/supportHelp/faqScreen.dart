import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/utils/text_style.dart';

import '../../../../bloc/profile/profile_bloc.dart';
import '../../../../model/response/faqResponse.dart';
import '../../../../utils/app_color_constant.dart';
import '../../../../utils/app_util.dart';
import '../../../../utils/reuseable_widget.dart';

class Faqscreen extends StatefulWidget {
  const Faqscreen({super.key});

  @override
  State<Faqscreen> createState() => _FaqscreenState();
}

class _FaqscreenState extends State<Faqscreen> {

  late ProfileBloc bloc;
  List<FaqResponse> settings=[];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      bloc.add(GetFAQsEvent());
    });
    super.initState();
    // Initialize the SlideAnimationManager
  }

  @override
  void dispose() {
    // Dispose the animation manager to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProfileBloc>(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileError){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, (){
              AppUtils.showSnack("${state.errorResponse.data}", context);
            });
          });
          bloc.initial();
        }
        if (state is UserFAQs){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            settings = state.response;
          });
          bloc.initial();
        }
        return OverlayLoaderWithAppIcon(
            isLoading:state is ProfileIsLoading,
            overlayBackgroundColor: AppColor.black40,
            circularProgressColor: AppColor.primary100,
            appIconSize: 60.h,
            appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
            child: Scaffold(body: appBodyDesign(getBody())));
      },
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 52.h, left: 20.w, bottom: 17.h),
            child: SizedBox(
                height: 52.h,
                child: CustomAppBar(title: "FAQ")),
          ),
          Gap(20.h),
          Container(
            height: 668.72.h,
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 24.w),
            decoration: BoxDecoration(
              color: AppColor.primary20,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r)),
            ),
            child: ListView(
              children: [
                ...settings.mapIndexed((element,index)=>
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 12.h),
                      child: AnimatedContainerExample(response: element),
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  navigateToNewScreen(int position){
    switch(position){
      case 0: return Get.to(Faqscreen());

    }
  }

}

class AnimatedContainerExample extends StatefulWidget {
  FaqResponse? response;
  AnimatedContainerExample({super.key,this.response});
  @override
  _AnimatedContainerExampleState createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 330.w,
        height: _isExpanded ? 200.h : 70.h,
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: AppColor.primary20,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 8)),
          ],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.response!.question,
             style:CustomTextStyle.kTxtMedium.copyWith(
              color: AppColor.primary100,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp
        ) ,
            ),
            if (_isExpanded)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                     widget.response!.answer,
                      style:CustomTextStyle.kTxtRegular.copyWith(
                          color: AppColor.black100,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp
                      ) ,
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _isExpanded = false;
                          });
                        },
                        child: Text(
                          'Close',
                         style: CustomTextStyle.kTxtMedium.copyWith(
                              color: AppColor.primary100,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp
                          ) ,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}