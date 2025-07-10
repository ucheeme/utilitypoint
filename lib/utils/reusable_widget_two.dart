import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/utils/image_paths.dart';
import 'package:utilitypoint/utils/reuseableFunctions.dart';
import 'package:utilitypoint/utils/reuseable_widget.dart';
import 'package:utilitypoint/utils/text_style.dart';

import '../model/response/cardTransactions.dart';
import '../model/response/airtimeDatatransactionHistory.dart';
import '../model/response/nairaDollarTransactionList.dart';
import 'app_color_constant.dart';
import 'app_util.dart';

class ProductTransactionWidgetDesgin extends StatelessWidget {
  ProductTransactionList transactionList;

  ProductTransactionWidgetDesgin({super.key, required this.transactionList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76.h,
      width: 343.w,
      padding: EdgeInsets.all(9.h),
      decoration: BoxDecoration(
        color: AppColor.black0,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 5)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          imageContainer(transactionList.transactionCategory),
          Gap(10.w),
          SizedBox(
            height: 58.h,
            width: 158.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${transactionList.description} to ${extractPhoneNumber(transactionList.userScreenMessage)}",
                  style: CustomTextStyle.kTxtBold.copyWith(
                      color: AppColor.black100,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  dateTimeFormatter(
                      transactionList.createdAt.toIso8601String()),
                  style: CustomTextStyle.kTxtMedium.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColor.black80),
                )
              ],
            ),
          ),
          SizedBox(
            width: 90.w,
            child: Text(
              textAlign: TextAlign.end,
              NumberFormat.currency(
                      symbol: transactionList.walletCategory == "naira_wallet"
                          ? '\₦'
                          : '\$',
                      decimalDigits: 0)
                  .format(double.parse(transactionList.amount)),
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: transactionList.transactionCategory == "fund"
                      ? AppColor.success100
                      : AppColor.Error100),
            ),
          )
        ],
      ),
    );
  }

  Widget imageContainer(String transactionType) {
    return Image.asset(
      transactionType == "fund" ? income_Image : expenses_Image,
      height: 48.h,
      width: 48.w,
    );
  }
}

class CardTransactionWidgetDesign extends StatelessWidget {
  CardTransactionList transactionList;

  CardTransactionWidgetDesign({super.key, required this.transactionList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: 335.w,
      padding: EdgeInsets.all(9.h),
      decoration: BoxDecoration(
        color: AppColor.black0,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 5)),
        ],
      ),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          imageContainer(transactionList.description?.toLowerCase() ?? ""),
          Gap(10.w),
          SizedBox(
            height: 50.h,
            width: 190.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transactionList.description ?? "",
                  style: CustomTextStyle.kTxtBold.copyWith(
                      color: AppColor.black100,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  dateTimeFormatter(
                      transactionList.createdAt.toIso8601String()),
                  style: CustomTextStyle.kTxtMedium.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                      color: AppColor.black80),
                )
              ],
            ),
          ),
          Expanded(
            child: Text(
              textAlign: TextAlign.end,
              NumberFormat.currency(
                      symbol: transactionList.currency != "USD" ? '\₦' : '\$',
                      decimalDigits: 0)
                  .format(double.parse(transactionList.amount ?? "0")),
              style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: (transactionList.description != null &&
                          transactionList.description!
                              .toLowerCase()
                              .contains("topup"))
                      ? AppColor.success100
                      : AppColor.Error100),
            ),
          )
        ],
      ),
    );
  }

  Widget imageContainer(String transactionType) {
    return Image.asset(
      transactionType != "topup" ? income_Image : expenses_Image,
      height: 45.h,
      width: 45.w,
    );
  }
}

class CustomDateRangePicker extends StatefulWidget {
  const CustomDateRangePicker({super.key});

  @override
  State<CustomDateRangePicker> createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  TextEditingController startDateControl = TextEditingController();
  TextEditingController endDateControl = TextEditingController();

  void _handleDateRangeChanged(args) {
    setState(() {
      DateTime? startDate = args.value.startDate;
      DateTime? endDate = args.value.endDate;
      DateTime today = DateTime.now();
      if (today.compareTo(endDate ?? today) == -1) {
        AppUtils.showSnack("Maximum end date should be today's date", context);
        startDateControl.text = "";
        endDateControl.text = "";
        return;
      }
      startDateControl.text = DateFormat('yyyy-MM-dd').format(startDate!);
      endDateControl.text = DateFormat('yyy-MM-dd').format(endDate!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 400.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColor.primary20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SfDateRangePicker(
                backgroundColor: AppColor.primary20,
                viewSpacing: 30.h,
                selectionMode: DateRangePickerSelectionMode.extendableRange,
                view: DateRangePickerView.month,
                headerHeight: 38.h,
                headerStyle: DateRangePickerHeaderStyle(
                    backgroundColor: AppColor.primary20,
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      color: AppColor.black100,
                      fontSize: 18.sp,
                      fontFamily: 'HKGroteskMedium',
                      fontWeight: FontWeight.w500,
                    )),
                toggleDaySelection: false,
                showNavigationArrow: true,
                //showActionButtons: true,
                selectionColor: AppColor.primary100,
                todayHighlightColor: AppColor.secondary100,
                rangeSelectionColor: AppColor.secondary100.withOpacity(0.50),

                selectionShape: DateRangePickerSelectionShape.rectangle,
                startRangeSelectionColor: AppColor.primary100,

                endRangeSelectionColor: AppColor.primary100,
                //selectionRadius: 15.r,
                selectionTextStyle: TextStyle(
                  color: AppColor.black0,
                  fontSize: 15.sp,
                  fontFamily: 'HKGroteskRegular',
                  fontWeight: FontWeight.w600,
                ),
                monthCellStyle: DateRangePickerMonthCellStyle(
                  cellDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColor.black0),
                  textStyle: TextStyle(
                    color: AppColor.black100,
                    fontSize: 13.sp,
                    fontFamily: 'HKGroteskRegular',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                yearCellStyle: DateRangePickerYearCellStyle(
                    cellDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: AppColor.black0),
                    textStyle: TextStyle(
                      color: AppColor.black80,
                      fontSize: 13.sp,
                      fontFamily: 'HKGroteskRegular',
                      fontWeight: FontWeight.w400,
                    )),
                monthViewSettings: DateRangePickerMonthViewSettings(
                    showWeekNumber: false,
                    dayFormat: "EEE",
                    viewHeaderHeight: 30.h,
                    showTrailingAndLeadingDates: false,
                    viewHeaderStyle: DateRangePickerViewHeaderStyle(
                        textStyle: TextStyle(
                      color: AppColor.primary100,
                      fontSize: 12.sp,
                      fontFamily: 'creatoDisplayMedium',
                      fontWeight: FontWeight.bold,
                    ))),
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  if (args.value.startDate != null &&
                      args.value.endDate != null) {
                    _handleDateRangeChanged(args);
                  }
                },
              ),
            ),
            Padding(
              padding: screenPad(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Start Date",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: AppColor.black100,
                        ),
                      ),
                      Container(
                        height: 40.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColor.primary100)),
                        child: Center(
                          child: Text(
                            startDateControl.text,
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: AppColor.black100,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(21.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "End Date",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: AppColor.black100,
                        ),
                      ),
                      Container(
                        height: 40.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColor.primary100)),
                        child: Center(
                          child: Text(
                            endDateControl.text,
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: AppColor.black100,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //     height:40.h,
                  //     child: CustomizedTextField(textEditingController:endDateControl, labeltxt: 'End date',))
                ],
              ),
            ),
            Gap(21.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: CustomButton(
                  height: 40.h,
                  borderRadius: 10.r,
                  buttonColor: AppColor.primary100,
                  textColor: AppColor.black0,
                  buttonText: "Proceed",
                  onTap: () {
                    if (startDateControl.text.isNotEmpty &&
                        endDateControl.text.isNotEmpty) {
                      StartDateEndDate startAndEndDate = StartDateEndDate(
                          startDate: startDateControl.text,
                          endDate: endDateControl.text);
                      Navigator.pop(context, startAndEndDate);
                    }
                    // return date range
                  }),
            ),
            Gap(25.h),
          ],
        ),
      ),
    );
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}

class SetDateTextFieldWidget extends StatelessWidget {
  final String title;

  const SetDateTextFieldWidget(
      {super.key, required this.dateControl, required this.title});

  final TextEditingController dateControl;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 47.h,
            width: 180.w,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: AppColor.secondary60,
                width: 0.5.h,
              ),
            ),
            child: TextFormField(
              enabled: false,
              controller: dateControl,
              cursorHeight: 15.h,
              cursorColor: AppColor.primary100,
              style: TextStyle(
                color: AppColor.black100,
                fontSize: 16.sp,
                fontFamily: 'HKGroteskMedium',
                fontWeight: FontWeight.w500,
              ),
              onChanged: (value) {},
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10.h),
                border: InputBorder.none,
              ),
              // textInputAction: TextInputAction.done,
            ),
          ),
          Positioned(
            left: 20.w,
            top: -10.h,
            child: Container(
              height: 19.h,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              color: AppColor.primary20,
              // Customize the background color of the label
              child: Text(title,
                  style: CustomTextStyle.kTxtRegular.copyWith(
                    fontSize: 16.sp,
                    color: AppColor.primary100,
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class StartDateEndDate {
  String startDate;
  String endDate;

  StartDateEndDate({
    required this.startDate,
    required this.endDate,
  });
}

EdgeInsets screenPad() => EdgeInsets.symmetric(horizontal: 13.w);

class NairaTransactionWidgetDesgin extends StatelessWidget {
  ProductTransactionList transactionList;

  NairaTransactionWidgetDesgin({super.key, required this.transactionList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78.h,
      width: 335.w,
      padding: EdgeInsets.all(9.h),
      decoration: BoxDecoration(
        color: AppColor.black0,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 5)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          imageContainer(transactionType()),
          Gap(10.w),
          SizedBox(
            height: 59.h,
            width: 168.w,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 35.h,
                  child: Text(
                    "${transactionList.transactionCategory.toLowerCase().capitalizeFirst} to ${getValue(transactionList)}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Text(
                  dateTimeFormatter(
                      transactionList.createdAt.toIso8601String()),
                  style: CustomTextStyle.kTxtMedium.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColor.black80),
                )
              ],
            ),
          ),
          SizedBox(
            width: 90.w,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    textAlign: TextAlign.end,
                    NumberFormat.currency(
                            symbol: '\₦', name: 'NGN', decimalDigits: 0)
                        .format(double.parse(transactionList.amount)),
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: checkIfSuccessful(transactionList.userScreenMessage)
                            ? AppColor.success100
                            : AppColor.Error100),
                  ),
                  Gap(6.h),
                  Container(
                    height: 20.h,
                    width: 110.w,
                    color: checkIfSuccessful(transactionList.userScreenMessage)
                        ? AppColor.success20
                        : AppColor.Error20,
                    child: Center(
                      child: Text(
                        checkIfSuccessful(transactionList.userScreenMessage)
                            ? "Successful"
                            : "Failed",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color:checkIfSuccessful(transactionList.userScreenMessage)
                                ? AppColor.success100
                                : AppColor.Error100),
                      ),
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }

  double amountGotten() {
    if (double.parse(transactionList.balanceAfter) >
        double.parse(transactionList.balanceBefore)) {
      return double.parse(transactionList.balanceAfter) -
          double.parse(transactionList.balanceBefore);
    } else {
      return double.parse(transactionList.balanceBefore) -
          double.parse(transactionList.balanceAfter);
    }
  }

  String transactionType() {
    if (double.parse(transactionList.balanceAfter) >
        double.parse(transactionList.balanceBefore)) {
      return "added";
    } else {
      return "purchase";
    }
  }

  Widget imageContainer(String transactionType) {
    return Image.asset(
      transactionType.toLowerCase().contains("purchase")
          ? expenses_Image
          : income_Image,
      height: 48.h,
      width: 48.w,
      color:
          checkIfSuccessful(transactionList.userScreenMessage)
          ? AppColor.success100
          : AppColor.Error100,
    );
  }

  bool checkIfSuccessful(String message) {
    if(message.contains("UnSuccessful") || message.contains("unsuccessful")
        ||message.contains("failed")||message.contains("Failed")){
      return false;
    }
    return message.contains("Successful") || message.contains("successful");
  }
}

class DollarTransactionWidgetDesgin extends StatelessWidget {
  NairaTransactionList transactionList;

  DollarTransactionWidgetDesgin({super.key, required this.transactionList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76.h,
      width: 335.w,
      padding: EdgeInsets.all(9.h),
      decoration: BoxDecoration(
        color: AppColor.black0,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 5)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          imageContainer(transactionList.transactionCategory),
          Gap(10.w),
          SizedBox(
            height: 58.h,
            width: 168.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transactionList.description,
                  style: CustomTextStyle.kTxtBold.copyWith(
                      color: AppColor.black100,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  dateTimeFormatter(
                      transactionList.createdAt.toIso8601String()),
                  style: CustomTextStyle.kTxtMedium.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColor.black80),
                )
              ],
            ),
          ),
          SizedBox(
            width: 90.w,
            child: Text(
              textAlign: TextAlign.end,
              getAmount(),
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: checkIfCreditDebit()
                      ? AppColor.Error100
                      : AppColor.success100),
            ),
          )
        ],
      ),
    );
  }

  bool checkIfCreditDebit() {
    return transactionList.transactionCategory
                       .toLowerCase().contains("purchase")||transactionList.transactionCategory
                    .toLowerCase().contains("create")||
        transactionList.description.toLowerCase().contains("top up dollar card from dollar wallet");
    ;
  }

  String getAmount(){
    if (double.parse(transactionList.balanceBefore) >
        double.parse(transactionList.balanceAfter)) {
      double amount = double.parse(transactionList.balanceBefore) -
          double.parse(transactionList.balanceAfter);
      return NumberFormat.currency(symbol: '\$', name: 'USD', decimalDigits: 0)
          .format(amount);
    } else {
      double amount = double.parse(transactionList.balanceAfter) -
          double.parse(transactionList.balanceBefore);
      print(amount);
      print("amount");
      return NumberFormat.currency(symbol: '\$', name: 'USD', decimalDigits: 0)
          .format(amount);
    }
  }

  Widget imageContainer(String transactionType) {
    print("transactionType: $transactionType");
    return Image.asset(
      transactionType.toLowerCase().contains("purchase")||transactionType.toLowerCase().contains("create")||
          transactionList.description.toLowerCase().contains("top up dollar card from dollar wallet")
          ? expenses_Image
          : income_Image,
      height: 48.h,
      width: 48.w,
    );
  }
}

class TransactionWidgetDesgin extends StatelessWidget {
  UserTransactions transactionList;

  TransactionWidgetDesgin({super.key, required this.transactionList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76.h,
      width: 335.w,
      padding: EdgeInsets.all(9.h),
      decoration: BoxDecoration(
        color: AppColor.black0,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 5)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          imageContainer(transactionType()),
          Gap(10.w),
          SizedBox(
            height: 58.h,
            width: 160.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 35.h,
                  child: Text(
                    transactionList.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Text(
                  dateTimeFormatter(
                      transactionList.createdAt.toIso8601String()),
                  style: CustomTextStyle.kTxtMedium.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColor.black80),
                )
              ],
            ),
          ),
          SizedBox(
            width: 90.w,
            child: Text(
              textAlign: TextAlign.end,
              NumberFormat.currency(
                      symbol:
                          (transactionList.walletCategory == "naira_wallet" ||
                                  transactionList.description
                                      .toLowerCase()
                                      .contains("from naira wallet"))
                              ? '\₦'
                              : '\$',
                      decimalDigits: 0)
                  .format(amountGotten()),
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: transactionList.description
                          .toLowerCase()
                          .contains("topup")
                      ? AppColor.success100
                      : AppColor.Error100),
            ),
          )
        ],
      ),
    );
  }

  double amountGotten() {
    if (double.parse(transactionList.balanceAfter) >
        double.parse(transactionList.balanceBefore)) {
      return double.parse(transactionList.balanceAfter) -
          double.parse(transactionList.balanceBefore);
    } else {
      return double.parse(transactionList.balanceBefore) -
          double.parse(transactionList.balanceAfter);
    }
  }

  String transactionType() {
    if (double.parse(transactionList.balanceAfter) >
        double.parse(transactionList.balanceBefore)) {
      return "added";
    } else {
      return "purchase";
    }
  }

  Widget imageContainer(String transactionType) {
    return Image.asset(
      transactionType.toLowerCase().contains("purchase")
          ? expenses_Image
          : income_Image,
      height: 48.h,
      width: 48.w,
    );
  }
}

class ReusableTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final bool isPassword;
  final bool? issearch;
  final int? maxlines;
  final validator;
  final Color? fillColor;
  final TextInputType textInputType;
  final Function(String data)? onchangedFunction;
  final Function()? ontapFunction;
  final bool? readOnlyBool;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;

  const ReusableTextFormField(
      {super.key,
      required this.controller,
      required this.isPassword,
      required this.validator,
      required this.textInputType,
      this.label,
      this.issearch,
      this.onchangedFunction,
      this.readOnlyBool,
      this.ontapFunction,
      this.focusNode,
      this.maxlines,
      this.fillColor,
      this.onFieldSubmitted});

  @override
  _ReusableTextFormFieldState createState() => _ReusableTextFormFieldState();
}

class _ReusableTextFormFieldState extends State<ReusableTextFormField> {
  @override
  void initState() {
    super.initState();
  }

  bool hidepassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        focusNode: widget.focusNode,
        validator: widget.validator,
        keyboardType: widget.textInputType,
        onChanged: widget.onchangedFunction,
        controller: widget.controller,
        obscureText: widget.isPassword == true ? hidepassword : false,
        onTap: widget.ontapFunction,
        maxLines: widget.isPassword == true ? 1 : widget.maxlines,
        style: TextStyle(
          color: Colors.black,
        ),
        readOnly: widget.readOnlyBool != null ? widget.readOnlyBool! : false,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          label: Text(widget.label != null ? widget.label! : ''),
          filled: false,
          // errorText: widget.validator,

          contentPadding: EdgeInsets.all(9),
          errorStyle: TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary100),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary100),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}

String getValue(ProductTransactionList productTransactionList) {
  if (productTransactionList.phoneNumber != null) {
    return productTransactionList.phoneNumber!;
  }
  if (productTransactionList.metreNumber != null) {
    return productTransactionList.metreNumber!;
  }
  if (productTransactionList.smartCardNumber != null) {
    return productTransactionList.smartCardNumber!;
  } else {
    return "";
  }
}

String extractPhoneNumber(String sentence) {
  // Regular expression to match a phone number starting with 234
  final regExp = RegExp(r'\b234\d{10}\b');

  // Find the first match
  final match = regExp.firstMatch(sentence);

  // Return the matched phone number or an empty string if no match is found
  return match != null ? match.group(0)! : '';
}
