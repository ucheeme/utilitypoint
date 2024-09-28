import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

import '../../utils/app_color_constant.dart';
import '../../utils/customClipPath.dart';
import '../../utils/reuseable_widget.dart';

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
      backgroundColor: AppColor.primary20,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start ,
        children: [
          dashboardHeader()
       ],
      ),
    );
  }
}
