import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/bloc/card/virtualcard_bloc.dart';
import 'package:utilitypoint/model/request/generateBankAcct.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/utils/reOccurringWidgets/transactionPin.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../../bloc/onboarding_new/onBoardingValidator.dart';
import '../../model/response/nairaFundingOptions.dart';
import '../../utils/app_color_constant.dart';
import '../../utils/app_util.dart';
import '../../utils/customAnimation.dart';
import '../../utils/reuseable_widget.dart';
import '../../utils/text_style.dart';
import '../menuOption/convertFunds/convert.dart';

class FundNairaWalletSection extends StatefulWidget {
   List<BankCode> bankCodes ;
  FundNairaWalletSection({super.key, required this.bankCodes});

  @override
  State<FundNairaWalletSection> createState() => _FundWalletScreeState();
}

class _FundWalletScreeState extends State<FundNairaWalletSection>  with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;

  int selectedItemPosition=0;

  late VirtualcardBloc bloc;

  List<NairaFundingOptions> nairaFundingOptions= [];
  @override
  void initState() {
    selectedOption=widget.bankCodes[0];
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
  BankCode? selectedOption;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<VirtualcardBloc>(context);
    return BlocBuilder<VirtualcardBloc, VirtualcardState>(
      builder: (context, state) {
        if (state is VirtualcardError){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, (){
              AppUtils.showSnack(state.errorResponse.message ?? "Error occurred", context);
            });
          });
          bloc.initial();
        }
        if (state is UserVirtualAccountGenerated){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSuccessSlidingModal(context,
            successMessage: "Your virtual account details is:"
                " ${state.response.data.accountNumber}/n"
                " ${state.response.data.accountName}/n ${state.response.data.bankName}"
            );
          });
          bloc.initial();
        }

        return OverlayLoaderWithAppIcon(
            isLoading:state is VirtualcardIsLoading,
            overlayBackgroundColor: AppColor.black40,
            circularProgressColor: AppColor.primary100,
            appIconSize: 60.h,
            appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
            child: Scaffold(body: appBodyDesign(getBody(),context: context)));
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
                  child: CustomAppBar(title: "Fund Wallet")),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _animationManager.slideAnimation,
            child: Container(
              height:MediaQuery.of(context).size.height,
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 24.w),
              decoration: BoxDecoration(
                color: AppColor.primary20,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r)),
              ),
              child: Column(
                children: [
                  ...widget.bankCodes.mapIndexed((element,index)=>
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedOption=element;
                              selectedItemPosition=index;
                            });
                          },
                          child: Container(
                            height: 70.h,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            margin: EdgeInsets.symmetric(vertical: 14.h),
                            decoration: BoxDecoration(
                              border: Border.all(color:selectedItemPosition==index?AppColor.primary100:AppColor.black60),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    offset: Offset(0, 8)),
                              ],
                              color: selectedItemPosition==index?AppColor.primary30:AppColor.black0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    element.bankName,
                                    style: CustomTextStyle.kTxtBold.copyWith(
                                        color:selectedItemPosition==index?AppColor.primary100:AppColor.black100,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Text(element.bankName.toLowerCase()=="access bank"?"You will be charged: ${element.bankCharges}%":
                                "You will be charged: NGN ${element.bankCharges}",
                                  style: GoogleFonts.inter(
                                      color: AppColor.black80,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                      )
                  ),
                  Gap(34.h),
                  CustomButton(onTap: () async {
                    List<dynamic>response = await Get.to(TransactionPin());
                    if(response[0]){

                      bloc.add(CreateUserVirtualAccountEvent(GenerateBankAccountRequest(
                        userId: loginResponse!.id,
                        bankCode: selectedOption!.bankCode,
                        pin: response[1],
                        fundingOptionId: selectedOption!.fundingOptionId,

                      )));
                    }
                  },
                    buttonText: "Generate virtual account",
                    borderRadius: 8.r,
                    buttonColor: selectedOption!=null?AppColor.primary100:AppColor.primary30,
                    textColor: AppColor.black0,
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
