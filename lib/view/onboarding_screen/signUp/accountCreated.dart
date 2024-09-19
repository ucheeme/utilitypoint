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

class _WelcomeScreenState extends State<WelcomeScreen>with TickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _controller;
  late Animation<Offset> _textAnimation;
  late Animation<Offset> _secondTextAnimation;
  late Animation<Offset> _imageAndButtonAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Slide animation for the first text (from top)
    _textAnimation = Tween<Offset>(
      begin: Offset(0, -1), // Start off-screen at the top
      end: Offset(0, 0),    // End at the original position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Slide animation for the second text (from the right)
    _secondTextAnimation = Tween<Offset>(
      begin: Offset(1, 0),  // Start off-screen on the right
      end: Offset(0, 0),    // End at the original position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Slide animation for the image and button (from the bottom with bounce)
    _imageAndButtonAnimation = Tween<Offset>(
      begin: Offset(0, 1),  // Start off-screen at the bottom
      end: Offset(0, 0),    // End at the original position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));

    // Trigger the animations to start after the build is complete
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isVisible = true;
        _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appBodyDesign(getBody()),
    );
  }
  getBody(){
    return Center(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal:20.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(66.h),
              SlideTransition(
                position: _textAnimation,
                child: AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    "Welcome to Utility Point, $firstNameTemp. Start Transacting!",
                    textAlign: TextAlign.start,
                    maxLines: 4,
                    style: CustomTextStyle.kTxtBold.copyWith(color: AppColor.black0,
                    fontSize: 32.sp,),
                  ),
                ),
              ),
              height16,
              SlideTransition(
                position: _secondTextAnimation,
                child: AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 700),
                  child: Text(
                    'Your account has been successfully created. You’re now ready to'
                        ' pay bills, and manage your finances all in one place.',
                    maxLines: 4,
                    style: CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black0,
                     fontSize: 16.sp,),
                  ),
                ),
              ),
              height60,
              SlideTransition(
                position: _imageAndButtonAnimation,
                child: Column(
                  children: [
                    AnimatedOpacity(
                      opacity: _isVisible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 900),
                      child: Image.asset('assets/image/images_png/registrastionComplete.png',
                        width: 292.76.w,
                        height: 286.h,
                      ),
                    ),
                   height20,
                    AnimatedOpacity(
                      opacity: _isVisible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 1000),
                      child: CustomButton(
                        buttonColor:AppColor.primary100,
                        textColor: AppColor.black0,
                        onTap: () {  },
                        buttonText: "Continue to Home",
                        height: 58.h,
                        borderRadius: 8.r,
          
                      ),
                    ),
                  ],
                ),
              ),
              height60
           ],
          ),
        ),
      ),
    );
  }
}


