import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:utilitypoint/utils/reusable_widget_two.dart';

import 'app_color_constant.dart';
import 'app_util.dart';

void copyToClipboard(BuildContext context, String textToCopy) {
  // Copy text to clipboard
  Clipboard.setData(ClipboardData(text: textToCopy));

  // Show a Snackbar to inform the user that the text was copied
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Copied to clipboard'),
      duration: Duration(seconds: 2), // Display the Snackbar for 2 seconds
    ),
  );
}


String formatWithCommas(String text) {
  if (text.isEmpty) return text;

  // Remove existing commas and non-digit characters
  text = text.replaceAll(',', '');
  text = text.replaceAll(RegExp(r'\D'), '');

  // Add commas in thousands place
  final formatter = NumberFormat('#,###.####');
  double value = double.parse(text);
  return formatter.format(value);
}

String dateTimeFormatter(String time){
  DateTime dateTime = DateTime.parse(time);
  // Define the format: 'd MMM, y • hh:mm a'
  String formattedDate = DateFormat('d MMM, y • hh:mm a').
  format(dateTime.toLocal());
  return formattedDate;
}

String generateRandomNumberString(int length) {
  Random random = Random();
  StringBuffer randomString = StringBuffer();

  for (int i = 0; i < length; i++) {
    randomString.write(random.nextInt(10)); // Generate random digits (0-9)
  }

  return randomString.toString();
}

void openRequestAccountStatementCalendar(BuildContext context,
    Function(StartDateEndDate) completionHandler)async {


  StartDateEndDate? result =await showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      backgroundColor:AppColor.black100,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(24.r),
            topLeft: Radius.circular(24.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child:  CustomDateRangePicker(),
      )
  );
  if (result != null){
    completionHandler(result);
    AppUtils.debug("start Date ${result.startDate}");
    AppUtils.debug("End Date ${result.endDate}");
  }
}