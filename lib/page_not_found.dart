
import 'package:flutter/material.dart';
import 'package:utilitypoint/utils/app_color_constant.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColor.primary60,
        body: Center(child: Text("Page not found", style: TextStyle(fontSize: 20),))
    );
  }
}