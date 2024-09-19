import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

import '../../utils/app_color_constant.dart';
import '../../utils/customClipPath.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.black100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ClipPath(
          //   clipper: ProsteBezierCurve(
          //     position: ClipPosition.top,
          //     list: [
          //
          //       BezierCurveSection(
          //         start: Offset(screenWidth/2, 0),
          //         top: Offset(screenWidth /4*3, 0),
          //         end: Offset(screenWidth / 2, 40),
          //       ),
          //       BezierCurveSection(
          //         start: Offset(screenWidth / 2, 30),
          //         top: Offset(screenWidth / 4, 60),
          //         end: Offset(0, 0),
          //       ),
          //     ],
          //   ),
          //   child: Container(
          //     height: 150.h,
          //     color: AppColor.black100,
          //     width: 375.w,
          //   ),
          // )
       ],
      ),
    );
  }
}
