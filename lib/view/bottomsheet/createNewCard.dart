import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/utils/reOccurringWidgets/transactionPin.dart';
import 'package:utilitypoint/view/home/home_screen.dart';
import 'package:utilitypoint/view/menuOption/convertFunds/convert.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../bloc/card/virtualcard_bloc.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/app_util.dart';
import '../../utils/height.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/text_style.dart';

class CreateNewCardScreen extends StatefulWidget {
  VirtualcardBloc bloc;
  bool isNaira = false;
  String cardCreationCharge = "";

  CreateNewCardScreen({super.key, required this.bloc,
    required this.cardCreationCharge,
    required this.isNaira});

  @override
  State<CreateNewCardScreen> createState() => _CreateNewCardScreenState();
}

class _CreateNewCardScreenState extends State<CreateNewCardScreen> {
  void onTextChanged() {
    final text = bloc.validation.amountController!.text;
    final newText = formatWithCommas(text);
    if (newText != text) {
      bloc.validation.amountController.value =
          bloc.validation.amountController.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  TextEditingController amountController = TextEditingController();

  String formatWithCommas(String text) {
    if (text.isEmpty) return text;

    // Remove existing commas and non-digit characters
    text = text.replaceAll(',', '');
    text = text.replaceAll(RegExp(r'\D'), '');

    // Add commas in thousands place
    final formatter = NumberFormat('#,###');
    int value = int.parse(text);
    return formatter.format(value);
  }
  late VirtualcardBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc =BlocProvider.of<VirtualcardBloc>(context);
    return BlocBuilder<VirtualcardBloc, VirtualcardState>(
      builder: (context, state) {
        if (state is VirtualcardError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, () {
              AppUtils.showSnack(
                  state.errorResponse.message ?? "Error occurred", context);
            });
          });
          bloc.initial();
        }

        if (state is CardCreationSuccessful) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context, true);
          });
          bloc.initial();
        }

        return OverlayLoaderWithAppIcon(
          isLoading: state is VirtualcardIsLoading,
          overlayBackgroundColor: AppColor.black40,
          circularProgressColor: AppColor.primary100,
          appIconSize: 60.h,
          appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
          child: Scaffold(
            backgroundColor: AppColor.primary20,
            body: Container(
              height: 420.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(30.h),
                    Text(
                     "Amount To Fund Card",
                      style: CustomTextStyle.kTxtBold.copyWith(
                          color: AppColor.black100,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp),
                    ),
                    height8,
                    StreamBuilder<Object>(
                        stream: bloc.validation.amount,
                        builder: (context, snapshot) {
                          return SizedBox(
                            height: 60.h,
                            child: CustomizedTextField(
                              textEditingController: amountController,
                              error: snapshot.error?.toString(),
                              keyboardType: TextInputType.name,
                              hintTxt: "Enter amount",
                              isTouched: bloc.validation.isAmountSelected,
                              onTap: () {
                                setState(() {
                                  bloc.validation.isAmountSelected =
                                      !bloc.validation.isAmountSelected;
                                });
                              },
                              onChanged: bloc.validation.setAmount,
                            ),
                          );
                        }),
                    height10,
                    Text(
                      "Currency",
                      style: CustomTextStyle.kTxtBold.copyWith(
                          color: AppColor.black100,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp),
                    ),
                    height8,
                    StreamBuilder<Object>(
                        stream: bloc.validation.currency,
                        builder: (context, snapshot) {
                          return DropdownButtonFormField<String>(
                            iconEnabledColor: AppColor.black60,
                            isDense: false,
                            items: bloc.validation.currencies
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: CustomTextStyle.kTxtRegular.copyWith(
                                      color: AppColor.black100,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp),
                                ),
                              );
                            }).toList(),
                            onChanged: bloc.validation.setCurrency,
                            decoration: InputDecoration(
                                fillColor: AppColor.black0,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.h, horizontal: 10.w),
                                hintText: "Currency",
                                isDense: true,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.black100, width: 0.5.w),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppColor.black100),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 0.2.w),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppColor.primary90),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.black100, width: 0.5.w),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                hintStyle: CustomTextStyle.kTxtRegular.copyWith(
                                    color: const Color(0xff7E8494),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp)),
                          );
                        }),
                    height24,
                    Text(
                      "Card Type",
                      style: CustomTextStyle.kTxtBold.copyWith(
                          color: AppColor.black100,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp),
                    ),
                    height8,
                    StreamBuilder<Object>(
                        stream: bloc.validation.cardTypee,
                        builder: (context, snapshot) {
                          return DropdownButtonFormField<String>(
                            iconEnabledColor: AppColor.black60,
                            isDense: false,
                            items: bloc.validation.cardType
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: CustomTextStyle.kTxtRegular.copyWith(
                                      color: AppColor.black100,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp),
                                ),
                              );
                            }).toList(),
                            onChanged: bloc.validation.setCardType,
                            decoration: InputDecoration(
                                fillColor: AppColor.black0,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.h, horizontal: 10.w),
                                hintText: "Card type",
                                isDense: true,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.black100, width: 0.5.w),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppColor.black100),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 0.2.w),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppColor.primary90),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.black100, width: 0.5.w),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                hintStyle: CustomTextStyle.kTxtRegular.copyWith(
                                    color: const Color(0xff7E8494),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp)),
                          );
                        }),
                    Gap(10.h),
                    Text(
                      "You will be charged USD ${widget.cardCreationCharge}",
                      style: CustomTextStyle.kTxtBold.copyWith(
                          color: AppColor.primary100,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                    ),
                    height20,
                    StreamBuilder<Object>(
                        stream: bloc.validation.createCardFundComplete,
                        builder: (context, snapshot) {
                          return CustomButton(
                            onTap: () async {
                              // Navigator.pop(context);
                              if (snapshot.hasData) {
                                if (widget.isNaira == false && double.parse(userDetails!.dollarWallet) == 0) {
                                  if((double.parse(userDetails!.nairaWallet) != 0))
                                  {
                                    Get.to(() => ConvertScreen(
                                        amountToConvert: amountController.text,
                                        isCreateCard:true
                                    )
                                    );
                                  }
                                  else{
                                    AppUtils.showInfoSnackFromBottom(
                                        "Insufficient Balance", context);
                                  }
                               } else {
                                  List<dynamic> response = await Get.to(TransactionPin());
                                  if(response[0]){
                                    bloc.add(CreateCardEvent(bloc.validation.
                                    createCardRequest(widget.cardCreationCharge,response[1])));
                                  }
                               }
                              } else {
                                AppUtils.showInfoSnackFromBottom(
                                    "All Field must be filled", context);
                              }
                            },
                            buttonText: "Done",
                            textColor: AppColor.black0,
                            borderRadius: 10.r,
                            buttonColor: snapshot.hasData
                                ? AppColor.primary100
                                : AppColor.black40,
                            height: 48.h,
                          );
                        })
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
