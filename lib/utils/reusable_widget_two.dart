import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:utilitypoint/utils/image_paths.dart';
import 'package:utilitypoint/utils/reuseableFunctions.dart';
import 'package:utilitypoint/utils/reuseable_widget.dart';
import 'package:utilitypoint/utils/text_style.dart';

import '../model/response/cardTransactions.dart';
import '../model/response/transactionHistory.dart';
import 'app_color_constant.dart';
import 'app_util.dart';

class ProductTransactionWidgetDesgin extends StatelessWidget {
  ProductTransactionList transactionList;
   ProductTransactionWidgetDesgin({super.key,required this.transactionList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66.h,
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
        children: [
          imageContainer(transactionList.transactionCategory),
          Gap(12.w),
          SizedBox(
            height: 44.h,
            width: 178.w,
            child: Column(
              children: [
                Text(transactionList.description,
                style: CustomTextStyle.kTxtMedium.copyWith(
                  color: AppColor.black100,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400
                ),),
                Text(dateTimeFormatter(transactionList.createdAt.toIso8601String()),
                  style: CustomTextStyle.kTxtMedium.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: AppColor.black80
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 90.w,
            child: Text(
                NumberFormat.currency(
                    symbol: transactionList.walletCategory=="naira_wallet"?'\₦' : '\$',
                    decimalDigits: 0)
                    .format(double.parse(transactionList.amount)),
              style: GoogleFonts.inter(
                color:transactionList.transactionCategory=="fund"?AppColor.success100:
                    AppColor.Error100
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget imageContainer(String transactionType){
    return Image.asset(transactionType!="fund"?income_Image:expenses_Image);
  }
}

class CardTransactionWidgetDesign extends StatelessWidget {
  CardTransactionList transactionList;
   CardTransactionWidgetDesign({super.key,required this.transactionList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66.h,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          imageContainer(transactionList.description?.toLowerCase()??""),
          Gap(12.w),
          SizedBox(
            height: 44.h,
            width: 178.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transactionList.description??"",
                  style: CustomTextStyle.kTxtBold.copyWith(
                      color: AppColor.black100,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w400
                  ),),
                Gap(4.h),
                Text(dateTimeFormatter(transactionList.createdAt.toIso8601String()),
                  style: CustomTextStyle.kTxtMedium.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                      color: AppColor.black80
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            child: Text(
              textAlign: TextAlign.end,
              NumberFormat.currency(
                  symbol: transactionList.currency!="USD"?'\₦' : '\$',
                  decimalDigits: 0)
                  .format(double.parse(transactionList.amount??"0")),
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                  color:(transactionList.description!=null && transactionList.description!.toLowerCase().contains("topup"))?AppColor.success100:
                  AppColor.Error100
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget imageContainer(String transactionType){
    return Image.asset(transactionType!="topup"?income_Image:expenses_Image);
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
      DateTime today =    DateTime.now();
      if (today.compareTo(endDate ?? today) == -1){
        AppUtils.showSnack("Maximum end date should be today's date", context);
        startDateControl.text = "";
        endDateControl.text = "";
        return;
      }
      startDateControl.text =
          DateFormat('dd-MM-yyyy').format(startDate!);
      endDateControl.text =
          DateFormat('dd-MM-yyyy').format(endDate!);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 660.h,width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color:AppColor.black0,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded (
            child: SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.extendableRange,
              view: DateRangePickerView.month,
              headerHeight: 58.h,
              headerStyle: DateRangePickerHeaderStyle(

                  backgroundColor: AppColor.primary100,
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    color: AppColor.black100,
                    fontSize: 18.sp,
                    fontFamily: 'HKGroteskMedium',
                    fontWeight: FontWeight.w500,
                  )
              ),
              toggleDaySelection: false,
              showNavigationArrow: true,
              //showActionButtons: true,
              selectionColor: AppColor.primary80,
              todayHighlightColor: AppColor.primary100,
              rangeSelectionColor: AppColor.primary100.withOpacity(0.50),

              selectionShape: DateRangePickerSelectionShape.rectangle,
              startRangeSelectionColor: AppColor.primary100.withOpacity(0.50),

              endRangeSelectionColor: Colors.red.withOpacity(0.50),
              //selectionRadius: 15.r,
              selectionTextStyle:TextStyle(
                color: AppColor.black0,
                fontSize: 15.sp,
                fontFamily: 'HKGroteskRegular',
                fontWeight: FontWeight.w600,
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                cellDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: AppColor.black80
                ),
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
                      color: AppColor.black80
                  ),
                  textStyle: TextStyle(
                    color: AppColor.black80,
                    fontSize: 13.sp,
                    fontFamily: 'HKGroteskRegular',
                    fontWeight: FontWeight.w400,
                  )
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                  showWeekNumber: false,
                  dayFormat: "EEE",
                  viewHeaderHeight: 40.h,
                  showTrailingAndLeadingDates: false,
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      textStyle: TextStyle(
                        color: AppColor.black100,
                        fontSize: 15.sp,
                        fontFamily: 'creatoDisplayMedium',
                        fontWeight: FontWeight.w500,
                      )
                  )
              ),
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args){

                if(args.value.startDate != null &&args.value.endDate != null){
                  _handleDateRangeChanged(args);
                }
              },),
          ),
          Padding(
            padding: screenPad(),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: SetDateTextFieldWidget(dateControl:startDateControl, title: 'Start date',)),
                Gap(21.w),
                Expanded(child: SetDateTextFieldWidget(dateControl:endDateControl, title: 'End date',))
              ],
            ),
          ),
          Gap(21.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: CustomButton(
                buttonText: "Proceed", onTap: (){
              if(startDateControl.text.isNotEmpty && endDateControl.text.isNotEmpty){
                StartDateEndDate startAndEndDate = StartDateEndDate(
                    startDate: startDateControl.text,
                    endDate: endDateControl.text );
                Navigator.pop(context,startAndEndDate);
              }
              // return date range
            }),
          ),
          Gap(25.h),
        ],
      ),
    );
  }
  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

}


class SetDateTextFieldWidget extends StatelessWidget {
  final String title;
  const SetDateTextFieldWidget({
    super.key,
    required this.dateControl,required this.title
  });

  final TextEditingController dateControl;

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none,
      children: [
        Container(
          height: 47.h,width: 180.w,
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
            cursorColor:AppColor.primary100,
            style: TextStyle(
              color: AppColor.black100, fontSize: 16.sp,
              fontFamily: 'HKGroteskMedium',
              fontWeight: FontWeight.w500,
            ),
            onChanged: (value){},
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
            color: AppColor.black80, // Customize the background color of the label
            child: Text(title,style: CustomTextStyle.kTxtRegular.copyWith(
              fontSize: 16.sp,
              color: AppColor.black100,
            ) ),
          ),
        )
      ],
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

