import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../model/request/buyAirtimeData.dart';
import '../../../model/response/dataPlanResponse.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/reOccurringWidgets/transactionPin.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import '../../onboarding_screen/signIn/login_screen.dart';
import 'confirmPayment.dart';

class BulkAirtimeConfirmPayment extends StatefulWidget {
  AirtimeRecharge airtimeRecharge;
  List<String>phonenumbers;
  List<ProductPlanItemResponse> productPlanList;

  BulkAirtimeConfirmPayment(
      {super.key,
        required this.phonenumbers,
        required this.airtimeRecharge,
        required this.productPlanList});

  @override
  State<BulkAirtimeConfirmPayment> createState() => _BulkAirtimeConfirmPaymentState();
}

class _BulkAirtimeConfirmPaymentState extends State<BulkAirtimeConfirmPayment>
    with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
  bool isCreateCard = false;
  late ProductBloc bloc;
  double amountToPay =0;

  @override
  void initState() {
    if (widget.productPlanList.isEmpty) {
      widget.productPlanList.add(ProductPlanItemResponse(
          productPlanId: "",
          amount: widget.airtimeRecharge.amount,
          sellingPrice: int.parse(widget.airtimeRecharge.amount),
          productPlanName: "",
          dataSizeInMb: "",
          validityInDays: "",
          automationId: ""));
      amountToPay =double.parse(widget.airtimeRecharge.amount)*widget.phonenumbers.length;
    }else{
      amountToPay = (widget.productPlanList[0].sellingPrice*widget.phonenumbers.length).toDouble();
    }


    if(widget.phonenumbers.last!=widget.airtimeRecharge.phoneNumber){
      widget.phonenumbers.add(widget.airtimeRecharge.phoneNumber);
    }
    super.initState();
    // Initialize the SlideAnimationManager
    _animationManager = SlideAnimationManager(this);
  }

  @override
  void dispose() {
    // Dispose the animation manager to avoid memory leaks
    _animationManager.dispose();
    super.dispose();
  }

  String userPin = "";

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProductBloc>(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, () {
              AppUtils.showSnack(
                  state.errorResponse.message ?? "Error occurred", context);
            });
          });
          bloc.initial();
        }
        //
        if (state is AirtimeBought) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.back();
            showSuccessSlidingModal(context,
                successMessage:state.response.message);

          });
          bloc.initial();
        }

        return OverlayLoaderWithAppIcon(
          isLoading: state is ProductIsLoading,
          overlayBackgroundColor: AppColor.black40,
          circularProgressColor: AppColor.primary100,
          appIconSize: 60.h,
          appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
          child: Scaffold(
            body: appBodyDesign(getBody()),
          ),
        );
      },
    );
  }

  getBody() {
    return Column(
      children: [
        SlideTransition(
          position: _animationManager.slideAnimationTop,
          child: Padding(
            padding: EdgeInsets.only(top: 52.h, left: 20.w, bottom: 17.h),
            child: SizedBox(
                height: 52.h, child: CustomAppBar(title: "Confirm Payment")),
          ),
        ),
        Gap(20.h),
        SlideTransition(
          position: _animationManager.slideAnimation,
          child: Container(
            height: 668.72.h,
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 24.w),
            decoration: BoxDecoration(
              color: AppColor.primary20,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 508.h,
                    width: 335.w,
                    child: ListView.builder(
                        itemCount: widget.phonenumbers.length,
                        itemBuilder:(context, index){
                      return BulkPreviewItem(
                        networkIcon:widget.airtimeRecharge.networkIcon ,
                        amount:widget.productPlanList.isEmpty?widget.airtimeRecharge.amount:widget.productPlanList[0].sellingPrice.toString(),
                        phoneNumber: widget.phonenumbers[index],
                        netWorkName: widget.airtimeRecharge.networkName,
                        onTap: (){
                          setState(() {
                            widget.phonenumbers.removeAt(index);
                          });
                        },
                      );
                    })
                  ),
              
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: SizedBox(
                      height: 28.h,
                      width: 295.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: CustomTextStyle.kTxtBold.copyWith(
                                color: AppColor.black100,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            NumberFormat.currency(
                                symbol: '\₦', decimalDigits: 1)
                                .format(
                                widget.productPlanList.isEmpty? (double.parse(widget.airtimeRecharge.amount)*widget.phonenumbers.length):
                                ( widget.productPlanList[0].sellingPrice*widget.phonenumbers.length).toDouble()),
                            style: CustomTextStyle.kTxtBold.copyWith(
                                color: AppColor.black100,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(42.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CustomButton(
                      onTap: () async {
                        List<dynamic> response = await Get.to(TransactionPin());
                        if(response[0]){
                          bloc.add(BuyAirtimeEvent(
                              BuyAirtimeDataRequest(
                                  networkId:widget.airtimeRecharge.networkId,
                                  userId: loginResponse!.id,
                                  phoneNumber:widget.phonenumbers.toString().replaceAll("[", "")
                                  .replaceAll("]", ""),
                                  productPlanCategoryId: widget.airtimeRecharge.productPlanCategoryId,
                                  pin: response[1],
                                  amount: widget.productPlanList.isEmpty?widget.airtimeRecharge.amount:
                                  widget.productPlanList[0].sellingPrice.toString()
                                  , walletCategory:"naira_wallet",
                                  validatephonenetwork: 0
                              )));
                        }
                      },
                      buttonText: "Confirm Payment",
                      height: 58.h,
                      textColor: AppColor.black0,
                      borderRadius: 8.r,
                      buttonColor: AppColor.primary100,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class BulkPreviewItem extends StatelessWidget {
  String phoneNumber;
  String netWorkName;
  String amount;
  String networkIcon;
  Function()? onTap;
   BulkPreviewItem({super.key,
     this.onTap,
     required this.networkIcon,required this.amount,required this.phoneNumber, required this.netWorkName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,

      child:   Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 238.h,
            width: 335.w,
            decoration: BoxDecoration(
                color: AppColor.black0,
                borderRadius: BorderRadius.circular(32.r)),
            child: Column(
              children: [
                Gap(25.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: SizedBox(
                    height: 28.h,
                    width: 295.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Network",
                          style: CustomTextStyle.kTxtRegular.copyWith(
                              color: AppColor.black60,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/image/icons/$networkIcon.png",
                              fit: BoxFit.contain,
                            ),
                            Gap(8.w),
                            Text(
                             netWorkName,
                              style: CustomTextStyle.kTxtBold.copyWith(
                                  color: AppColor.black100,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const Divider(
                    color: AppColor.black60,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: SizedBox(
                    height: 28.h,
                    width: 295.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mobile Number",
                          style: CustomTextStyle.kTxtRegular.copyWith(
                              color: AppColor.black60,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          phoneNumber,
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const Divider(
                    color: AppColor.black60,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: SizedBox(
                    height: 28.h,
                    width: 295.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount",
                          style: CustomTextStyle.kTxtRegular.copyWith(
                              color: AppColor.black60,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          NumberFormat.currency(
                              symbol: '\₦', decimalDigits: 0)
                              .format(double.parse(
                              amount)),
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                //   child: const Divider(
                //     color: AppColor.black60,
                //   ),
                // ),
              ],
            ),
          ),
          Gap(12.h),
          GestureDetector(
            onTap:onTap,
            child: SizedBox(
              height:30.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Delete Entry",
                    style: CustomTextStyle.kTxtMedium.copyWith(
                        color: AppColor.primary100,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp),
                  ),
                Gap(9.w),
                Image.asset("assets/image/icons/bulk_delete_Icon.png",
                height: 24.h,width: 24.w,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

