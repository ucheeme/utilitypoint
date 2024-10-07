import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:utilitypoint/utils/constant.dart';

import '../../utils/app_color_constant.dart';
import '../../utils/text_style.dart';

class CurrencyOptions extends StatefulWidget {
  String currentCurrency;

  CurrencyOptions({super.key, required this.currentCurrency});

  @override
  State<CurrencyOptions> createState() => _CurrencyOptionsState();
}

class _CurrencyOptionsState extends State<CurrencyOptions> {
  List<String> currencies = ["USD", "NGN"];
  List<String> tempcurrencies = [];

  @override
  void initState() {
    tempcurrencies = currencies
        .where((element) =>
            element.toLowerCase() != widget.currentCurrency.toLowerCase())
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.2, // Initial size of the bottom sheet
        minChildSize: 0.1,
        builder: (_, controller) => Container(
              color: AppColor.black0,
              child: Column(
                children: [
                  ...tempcurrencies
                      .mapIndexed((element, indexed) => GestureDetector(
                            onTap: () {
                              Navigator.pop(context, element);
                            },
                            child: Container(
                              height: 50.h,
                              width: 335.w,
                              margin: EdgeInsets.symmetric(vertical: 16.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 8,
                                      offset: Offset(0, 8)),
                                ],
                                color: AppColor.black0,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  element,
                                  style: CustomTextStyle.kTxtBold.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.black100),
                                ),
                              ),
                            ),
                          ))
                ],
              ),
            ));
  }
}
