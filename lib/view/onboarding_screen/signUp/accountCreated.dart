import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:utilitypoint/utils/text_style.dart';

import '../../../utils/app_color_constant.dart';
import '../../../utils/custom_keypad.dart';
import '../../../utils/height.dart';
import '../../../utils/pages.dart';
import '../../../utils/reuseable_widget.dart';

String firstNameTemp ="";
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _slideControllerTop;
  TextEditingController pinValueController=TextEditingController();
  TextEditingController ttController=TextEditingController();
  late Animation<Offset> _slideAnimation;
  late Animation<double> _slideAnimationTop;



  @override
  void initState() {

    super.initState();

    // Slide Animation
    _slideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _slideControllerTop = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _slideAnimationTop = Tween<double>(
      begin: -100,
      end: 100,
    ).animate(CurvedAnimation(
      parent: _slideControllerTop,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    _slideController.forward();
    _slideControllerTop.forward();
  }

  @override
  void dispose() {
    _slideControllerTop.dispose();
    _slideController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appBodyDesign(getBody()),
    );
  }
  getBody(){
    return Column(
      children: [
        Gap(66.h),
        AnimatedBuilder(
          animation: _slideAnimationTop,
          builder: (BuildContext context, Widget? child) {
            return Positioned(
              top: _slideAnimationTop.value,
              left: MediaQuery.of(context).size.width / 2 - 50, // Center the text horizontally
              child: child!,
            );
          },
          child: SizedBox(
            height: 150.h,
            width: 335.w,
            child: Text(
              "Welcome to Utility Point, $firstNameTemp. Start Transacting!",
              textAlign: TextAlign.start,
              maxLines: 4,
              style: CustomTextStyle.kTxtBold.copyWith(color: AppColor.black0,
              fontSize: 32.sp,),
            ),
          ),
        )
     ],
    );
  }
}


