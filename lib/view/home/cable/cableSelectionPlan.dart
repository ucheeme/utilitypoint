import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/view/home/airtimePurchase/confirmPayment.dart';
import 'package:utilitypoint/view/home/home_screen.dart';
import 'package:utilitypoint/view/onboarding_screen/signUp/accountCreated.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../bloc/profile/profile_bloc.dart';
import '../../../model/request/confirmElectricityMeterOrCableName.dart';
import '../../../model/request/getProduct.dart';
import '../../../model/response/dataPlanCategory.dart';
import '../../../model/response/dataPlanResponse.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import '../../onboarding_screen/signIn/login_screen.dart';
import 'cableListView.dart';
import 'confirmAndBuyCableSub.dart';

class CableTvSelection extends StatefulWidget {
  ProductPlanCategoryItem productPlanCategoryItem;
   CableTvSelection({super.key,required this.productPlanCategoryItem});

  @override
  State<CableTvSelection> createState() => _CableTvSelectionState();
}

class _CableTvSelectionState extends State<CableTvSelection>with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;

  TextEditingController smartCardNumber = TextEditingController();
  TextEditingController cardName = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();
  late ProductBloc bloc;
  List<ProductPlanItemResponse> productPlanList=[];
  int selectedDataPlan =0;
  String productPlanId ="";
  ProductPlanItemResponse? selectedProductPlan;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      bloc.add(GetAllProductPlanEvent(GetProductRequest(
          userId: loginResponse!.id,
          planCategoryId:widget.productPlanCategoryItem.id,
          // amount: airtimeAmountController.text.trim(),
          productSlug: "cable_subscription"
      )));
    });
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

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProductBloc>(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductError){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, (){
              AppUtils.showSnack(state.errorResponse.message ?? "Error occurred", context);
            });
          });
          bloc.initial();
        }
        if (state is AllProductPlanSuccess){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            productPlanList= state.response;
            productPlanId=productPlanList[0].productPlanId;
            selectedProductPlan= productPlanList[0];
          });
          bloc.initial();
        }
        if (state is CableNameConfirm){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            cardName.text= state.response.name.replaceAll("Defaulted to:", "");

          });
          bloc.initial();
        }


        return OverlayLoaderWithAppIcon(
            isLoading:state is ProductIsLoading,
            overlayBackgroundColor: AppColor.black40,
            circularProgressColor: AppColor.primary100,
            appIconSize: 60.h,
            appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
            child: Scaffold(body: appBodyDesign(getBody())));
      },
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SlideTransition(
            position: _animationManager.slideAnimationTop,
            child: Padding(
              padding: EdgeInsets.only(top: 52.h, left: 20.w, bottom: 17.h),
              child: SizedBox(
                  height: 52.h,
                  child: CustomAppBar(title: "Cable Tv")),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 91.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                          child: Text(
                            "Smartcard Number",
                            style: CustomTextStyle.kTxtBold.copyWith(
                                color: AppColor.black100,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp),
                          ),
                        ),
                        SizedBox(
                          height: 58.h,
                          child: CustomizedTextField(
                            maxLength: 10,
                              textEditingController:smartCardNumber,
                              keyboardType:TextInputType.number,
                              onChanged: (value){
                                if(value.length==10){
                                  bloc.add(ConfirmCableNameEvent(
                                      ConfirmMeterOrCableNameRequest(
                                          userId: loginResponse!.id,
                                          pin:userDetails!.pin,
                                          smartCardNumber: value,
                                          productPlanId: selectedProductPlan!.productPlanId
                                      )
                                  ));
                                }
                              },
                              isTouched: false),
                        ),
                      ],
                    ),
                  ),
                  Gap(22.h),
                  Text(
                    "Cable Plan",
                    style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp),
                  ),
                  Gap(8.h),
                  SizedBox(
                    height: 200.h,
                    child:  GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // 4 items per row
                          crossAxisSpacing: 10.h, // Spacing between columns
                          mainAxisSpacing: 10.w, // Spacing between rows
                        ),
                        itemCount: productPlanList.length,
                        itemBuilder: (context, index){
                          return GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectedDataPlan=index;
                                });
                                productPlanId=productPlanList[index].productPlanId;
                                selectedProductPlan= productPlanList[index];
                              },
                              child: cablePlanCard(productPlanList[index], selectedDataPlan==index)
                          );
                        }),
                  ),
                  SizedBox(
                    height: 103.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Card Name",
                          style: CustomTextStyle.kTxtBold.copyWith(
                              color: AppColor.black100,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 58.h,
                          child: CustomizedTextField(
                              textEditingController: cardName,
                              keyboardType: TextInputType.phone,
                              readOnly: true,
                              isTouched: false),
                        ),

                      ],
                    ),
                  ),
                  CustomButton(
                    onTap: () async {
                      if(cardName.text.isNotEmpty&&smartCardNumber.text.isNotEmpty){
                     AirtimeRecharge firstValue=   AirtimeRecharge(
                            networkId: selectedProductPlan!.productPlanId,
                            number: smartCardNumber.text,
                            productPlanCategoryId: widget.productPlanCategoryItem.id,
                            networkName: widget.productPlanCategoryItem.productPlanCategoryName,
                            networkIcon: getCableLogo(widget.productPlanCategoryItem.productPlanCategoryName),
                            amount: selectedProductPlan!.sellingPrice,
                          cableName: cardName.text,
                        );
                     Get.to(ConfirmBillsPayment(airtimeRecharge: firstValue, productPlanList: selectedProductPlan!,));
                      }else{
                        AppUtils.showSnack("No Field should be empty", context);
                      }

                    },
                    buttonText: "Next",
                    buttonColor: AppColor.primary100,
                    textColor: AppColor.black0,
                    borderRadius: 8.r,
                    height: 58.h,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}