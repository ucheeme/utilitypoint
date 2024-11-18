import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/model/request/unfreezeCard.dart';
import 'package:utilitypoint/view/menuOption/cards/CardDesign.dart';

import '../../../bloc/card/virtualcard_bloc.dart';
import '../../../model/request/getUserRequest.dart';
import '../../../model/response/listofVirtualCard.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/app_util.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/height.dart';
import '../../../utils/reOccurringWidgets/transactionPin.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import '../../bottomsheet/createNewCard.dart';
import '../../onboarding_screen/signIn/login_screen.dart';
import '../convertFunds/convert.dart';
import 'cardTransactionHistory.dart';

class CreateCustomerDetails extends StatefulWidget {
  bool isNaira = true;
  CreateCustomerDetails({super.key, required this.isNaira});

  @override
  State<CreateCustomerDetails> createState() => _CreateCustomerDetailsState();
}

class _CreateCustomerDetailsState extends State<CreateCustomerDetails> with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;
 
  late VirtualcardBloc bloc;
  String cardCreationCharge ="";
  bool isCreatNewCard = false;
  TextEditingController dobController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  final List<String> countries = [
    "United States",
    "Canada",
    "Australia",
    "United Kingdom",
    "Germany",
    "France",
    "India",
    "China",
    "Japan",
    "Brazil",
    "South Africa",
    "Russia",
    "Mexico",
    "Italy",
    "Spain",
    "Nigeria"
    // Add more countries as needed
  ];

  // Selected country
  String? selectedCountry;

  @override
  void initState() {
  
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
        if (state is AllUserVirtualCards){
          WidgetsBinding.instance.addPostFrameCallback((_) {
           // userCards = state.response;
          });
          bloc.initial();
        }
        if (state is CardFreezeSuccessful){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            bloc.add(GetUserCardEvent(GetUserIdRequest(userId: loginResponse!.id)));
            AppUtils.showSuccessSnack("Card Freezed Successfully!", context);

          });
          bloc.initial();
        }
        if (state is CardUnFreezeSuccessful){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            bloc.add(GetUserCardEvent(GetUserIdRequest(userId: loginResponse!.id)));
            AppUtils.showSuccessSnack("Card UnFreezed Successfully!", context);
          });
          bloc.initial();
        }

        if (state is ExchangeRate){
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            cardCreationCharge = state.response.cardCreationFeeInCurrency;
            if(cardCreationCharge.isNotEmpty && isCreatNewCard){
              bool response=  await showCupertinoModalBottomSheet(
                  topRadius:
                  Radius.circular(10.r),
                  backgroundColor: Colors.white,
                  context: context,
                  builder: (context) {
                    return
                      Container(
                          height: 500.h,
                          color: AppColor.primary20,
                          child:  CreateNewCardScreen(bloc: bloc,
                            isNaira:widget.isNaira,
                            cardCreationCharge: cardCreationCharge,)
                      );
                  });
              if(response){
                bloc.add(GetUserCardEvent(GetUserIdRequest(userId: loginResponse!.id)));
                showSuccessSlidingModal(
                    context,
                    successMessage: "Your Dollar Debit card was created and funded successfully!");
              }
            }

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
            body: appBodyDesign(getBody()),
          ),
        );
      },
    );
  }
  Widget getBody(){
    return SingleChildScrollView(
      child: Column(
        children: [
          SlideTransition(
            position: _animationManager.slideAnimationTop,
            child: Padding(
              padding:  EdgeInsets.only(top: 52.h,left: 20.w,bottom: 17.h),
              child: SizedBox(
                  height: 52.h,
                  child: CustomAppBar(title: "Create Billing Address")),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _animationManager.slideAnimation,
            child: Container(
              height: 668.72.h,
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 26.h,horizontal: 24.w),
              decoration: BoxDecoration(
                color: AppColor.primary20,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r),topRight: Radius.circular(30.r)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Text("Date Of Birth",
                   style: CustomTextStyle.kTxtMedium.copyWith(
                     color: AppColor.black100,
                     fontSize: 14.sp,
                     fontWeight: FontWeight.w500
                   ),),
                    height4,
                    CustomizedTextField(
                      textEditingController: dobController,
                     readOnly: true,
                      onTap: (){_selectDate(dobController);},
                    ),
                    Center(
                      child: DropdownButtonFormField<String>(
                        value: selectedCountry,
                        hint: Text("Choose a country",
                          style: CustomTextStyle.kTxtMedium.copyWith(
                              color: AppColor.black100,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        icon: Icon(Icons.arrow_drop_down),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        ),
                        isExpanded: true,
                        items: countries.map((country) {
                          return DropdownMenuItem(
                            value: country,
                            child: Text(country),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCountry = value;
                          });
                        },
                      ),
                    ),
                    height16,
                    Text("Street",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.black100,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                      ),),
                    height4,
                    CustomizedTextField(
                      textEditingController: streetController,
                    ),
                    // height12,
                    Text("City",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.black100,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                      ),),
                    height4,
                    CustomizedTextField(
                      textEditingController: cityController,
                    ),
                    // height12,
                    Text("State",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.black100,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                      ),),
                    height4,
                    CustomizedTextField(
                      textEditingController: stateController,
                    ),
                    // height16,
                    Text("Postal code",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.black100,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                      ),),
                    height4,
                    CustomizedTextField(
                      textEditingController: postalCodeController,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(onTap: () async {
                        isCreatNewCard= true;
                        if(currencyConversionRateFees==null){
                          bloc.add(GetExchangeRateEvent());
                        }else{
                          cardCreationCharge = currencyConversionRateFees!.cardCreationFeeInCurrency;
                
                          bool response=  await showCupertinoModalBottomSheet(
                              topRadius: Radius.circular(10.r),
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (context) {
                                return
                                  Container(
                                      height: 500.h,
                                      color: AppColor.primary20,
                                      child:  CreateNewCardScreen(bloc: bloc,
                                        isNaira:widget.isNaira,
                                        cardCreationCharge: cardCreationCharge,)
                                  );
                              });
                          if(response){
                            bloc.add(GetUserCardEvent(GetUserIdRequest(userId: loginResponse!.id)));
                            showSuccessSlidingModal(
                                context,
                                successMessage: "Your Dollar Debit card was created and funded successfully!");
                          }
                        }
                
                      },
                        buttonText: "Create New Card",
                        buttonColor: AppColor.primary100,
                        textColor: AppColor.black0,
                        borderRadius:8.r,
                        height: 58.h,
                        icon: Icons.add_circle_outline,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Future<void> _selectDate(TextEditingController controller,
      {String labelText = "",}) async {
    DateTime? response = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1890),
        lastDate: DateTime(2100));

    if (response != null) {
      controller.text = response.format("Y-m-d");
      setState(() {
        // if(isExpiryDate){
        //   expiredDate=response.format("m/d/Y h:i A");
        // }
        labelText = controller.text;
      });
    }
  }
}


