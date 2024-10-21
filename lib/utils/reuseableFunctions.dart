import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:utilitypoint/utils/constant.dart';
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
 // text = text.replaceAll(',', '');
 // text = text.replaceAll( RegExp(r'^\d{1,3}(,\d{3})*(\.\d{1,2})?$'), '');

  // Add commas in thousands place
  final formatter = NumberFormat('#,###.####');
  double value = double.parse(text);
  return formatter.format(value);
}

String dateTimeFormatter(String time){
  DateTime dateTime = DateTime.parse(time);
  // Define the format: 'd MMM, y • hh:mm a'
  String formattedDate = DateFormat('d MMM, y     •    hh:mm a').
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

String getNetworkProvider(String phoneNumber) {
  // Clean the phone number by removing any spaces, dashes, or country code
  phoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

  // Remove country code if it's there (assuming it's +234 for Nigeria)
  if (phoneNumber.startsWith('234')) {
    phoneNumber = phoneNumber.substring(3);
  } else if (phoneNumber.startsWith('+234')) {
    phoneNumber = phoneNumber.substring(4);
  }

  // Check if phone number starts with '0' after removing country code
  if (phoneNumber.startsWith('0')) {
    phoneNumber = phoneNumber.substring(1);
  }


  // Check if the phone number has a valid network prefix
  String prefix = phoneNumber.substring(0, 3); // First 3 digits
  return networkPrefixes[prefix] ?? 'Unknown network provider';
}

Map<String, double> convertMB(double mb) {
  // Conversion factors
  double kb = mb * 1024;  // MB to KB
  double gb = mb * 0.0009765625;  // MB to GB
  double tb = mb * 9.53674316e-7;  // MB to TB

  return {
    'KB': kb,
    'GB': gb,
    'TB': tb,
  };
}

String getDataValue(double mb){
  if(mb>=1024){
   mb =mb*0.0009765625;
    return "${mb.toStringAsFixed(0)}GB";
  }else{
    return "${mb.toStringAsFixed(0)}MB";
  }
}
String extractSizeValue(String input) {
  // Regular expression to find a number followed by 'MB', 'GB', or 'KB'
  RegExp regExp = RegExp(r'(\d+(?:\.\d+)?\s*(MB|GB|KB))', caseSensitive: false);

  // Use RegExp to search the input string
  Match? match = regExp.firstMatch(input);

  // If a match is found, return the matched group (e.g., '1024MB', '1.5GB')
  if (match != null) {
    return match.group(0)!; // Group 0 contains the full match (number + unit)
  } else {
    return 'No size value found'; // In case there is no match
  }
}
Future<dynamic> openBottomSheet(BuildContext context,Widget bottomScreen,{background=AppColor.black0}) {
  return showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      backgroundColor:background,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(24.r),topLeft: Radius.circular(24.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child:  bottomScreen,
      )
  );
}