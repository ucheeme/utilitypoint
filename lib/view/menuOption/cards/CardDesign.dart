import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:utilitypoint/model/response/cardDetailInformation.dart';
import 'package:utilitypoint/utils/image_paths.dart';

import '../../../model/response/listofVirtualCard.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/reuseableFunctions.dart';
import '../../../utils/reuseable_widget.dart';
import '../../../utils/text_style.dart';
import 'cardDetails.dart';
import 'cardTransactionHistory.dart';

class CardDesign extends StatefulWidget {
  UserVirtualCards? cardDetail;
  bool? isVirtualCardScreen;
   CardDesign({super.key,this.cardDetail,this.isVirtualCardScreen});

  @override
  State<CardDesign> createState() => _CardDesignState();
}

class _CardDesignState extends State<CardDesign> {
  bool showCardDetails =false;
  @override
  Widget build(BuildContext context) {

    return  GestureDetector(
      onTap: (){
        if(widget.isVirtualCardScreen!=true||widget.isVirtualCardScreen==null){
          Get.to(()=>CardInformation(userVirtualCards: widget.cardDetail,));
        }else{
          Get.to(()=>CardTransactionHistory(cardId: widget.cardDetail!.cardId,));
        }
      },
      child: Container(
          height: 167.h,
          width: 335.w,
          margin: EdgeInsets.symmetric(vertical: 16.h),
          padding: EdgeInsets.symmetric(vertical: 20.h,),
          decoration: BoxDecoration(
             color:(widget.cardDetail?.freezeStatus=="1")?AppColor.iceColor:
             widget.cardDetail!.brand=="MASTERCARD"?AppColor.black100:AppColor.visaCard,
              borderRadius: BorderRadius.circular(16.r)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w),
                child: SizedBox(
                  height: 20.h,
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Debit",
                        style:CustomTextStyle.kTxtMedium.copyWith(
                            color: AppColor.black10,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400
                        ) ,),
                      Image.asset(widget.cardDetail!.brand=="MASTERCARD"?masterCard:visaCard)
                    ],
                  ),
                ),
              ),
           Gap(20.h),
           SizedBox(
             height:86.h,
             width: 335.w,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Padding(
                   padding:  EdgeInsets.symmetric(horizontal: 16.w),
                   child: Column(
                     children: [
                       SizedBox(
                         height:33.h,
                         width: 277.w,
                         child: Text(
                           showCardDetails?widget.cardDetail!.cardNumber:
                           "**** ****  **** ${widget.cardDetail!.cardLastFour}",
                           style:  GoogleFonts.inter(
                               color: AppColor.black0,
                               fontWeight: FontWeight.w700,
                               fontSize: 26.sp
                           ),),
                       ),
                       Gap(20.h),
                       SizedBox(
                         width: 277.w,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Column(
                               children: [
                                 Text("Expiry",style: GoogleFonts.nunitoSans(
                                   color: AppColor.black40,
                                     fontWeight: FontWeight.w400,
                                     fontSize: 10.sp
                                 ),),
                                 Text(widget.cardDetail!.cardExpiry,style: GoogleFonts.nunitoSans(
                                   color: AppColor.black0,
                                     fontWeight: FontWeight.w700,
                                     fontSize: 10.sp
                                 ),),

                               ],
                             ),
                             Column(
                               children: [
                                 Text("CVV",style: GoogleFonts.nunitoSans(
                                   color: AppColor.black40,
                                     fontWeight: FontWeight.w400,
                                     fontSize: 10.sp
                                 ),),
                                 Text(widget.cardDetail!.cardCcv,style: GoogleFonts.nunitoSans(
                                   color: AppColor.black0,
                                     fontWeight: FontWeight.w700,
                                     fontSize: 10.sp
                                 ),),

                               ],
                             ),
                           ],
                         ),
                       )
                     ],
                   ),
                 ),
                 SizedBox(
                     height: 83.h,
                     child: Image.asset("assets/image/images_png/cardDesign.png",
                     alignment: Alignment.topCenter,))
               ],

             ),
           ),

            ],
          ),
        ),
    );
  }
}

class CardInfoDesign extends StatelessWidget {
  UserVirtualCards? cardDetail;
  bool? isVirtualCardScreen;
  SingleCardInformation? information;
   CardInfoDesign({super.key, this.cardDetail, this.isVirtualCardScreen,
   this.information
   });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(isVirtualCardScreen!=true||isVirtualCardScreen==null){
        //  Get.to(()=>CardInformation(userVirtualCards: cardDetail,));
        }else{
          Get.to(()=>CardTransactionHistory(cardId: cardDetail!.cardId,));
        }
      },
      child: Container(
        height: 167.h,
        width: 335.w,
        margin: EdgeInsets.symmetric(vertical: 16.h),
        padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 14.w),
        decoration: BoxDecoration(
            color:(cardDetail?.freezeStatus=="1")?AppColor.iceColor:
           cardDetail!.brand=="MASTERCARD"?AppColor.black100:AppColor.visaCard,
            borderRadius: BorderRadius.circular(16.r)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/image/icons/appSmallLogo.png"),
                  Visibility(
                    visible: information!=null,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: NumberFormat.currency(
                                  symbol:  '\$', decimalDigits: 0)
                                  .format(information==null?0:information!.message.details.balance.toDouble()),
                              style: GoogleFonts.inter(
                                  color: AppColor.black0,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp)),
                          TextSpan(
                              text:
                              '.${double.parse(cardDetail!.amount).toString().split(".")[1]}',
                              style: GoogleFonts.inter(
                                  color: AppColor.black10,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp)),
                        ],
                      ),
                    ),
                  ),
                 //
                ],
              ),
            ),
            Gap(39.h),
            SizedBox(
              height: 23.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 23.h,
                    width: 188.w,
                    child: Row(
                      children: [
                        Text(
                          cardDetail!.cardNumber,
                          style:  GoogleFonts.inter(
                              color: AppColor.black0,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp
                          ),),
                        Gap(3.w),
                        GestureDetector(
                          onTap: (){
                            copyToClipboard(
                                context, cardDetail!.cardNumber);
                          },
                          child: Image.asset(
                            "assets/image/icons/fi_copy.png",
                            height: 16.h,
                            width: 16.w,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    cardDetail!.cardExpiry,
                    style: CustomTextStyle.kTxtMedium.copyWith(
                        color: AppColor.black0,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp
                    ),),
                ],
              ),
            ),
            Gap(25.h),
            SizedBox(
              height: 20.h,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cardDetail!.cardName,
                    style: CustomTextStyle.kTxtMedium.copyWith(
                        color: AppColor.black0,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp
                    ),),
                  Image.asset(cardDetail!.brand=="MASTERCARD"?masterCard:visaCard)
                ],
              ) ,
            ),
          ],
        ),
      ),
    );
  }
}

class CardBackView extends StatelessWidget {
  UserVirtualCards? cardDetail;
  SingleCardInformation? information;
   CardBackView({super.key, this.cardDetail, this.information});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height:164.h,
        width: 335.w,
        padding: EdgeInsets.only(left: 20.w,top: 24.h),
        decoration: BoxDecoration(
          color: AppColor.black100,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
              width: 192.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Country:",
                  style: CustomTextStyle.kTxtMedium.copyWith(
                    color: AppColor.black0,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800
                  ),
                  ),
               Row(
                 children: [
                   Text(information!.message.details.billing.country??"no country",
                     style: CustomTextStyle.kTxtMedium.copyWith(
                         color: AppColor.black0,
                         fontSize: 14.sp,
                         fontWeight: FontWeight.w400
                     ),
                   ),
                   Gap(3.w),
                   GestureDetector(
                     onTap: (){
                       copyToClipboard(
                           context,information!.message.details.billing.country??"");
                     },
                     child: Image.asset(
                       "assets/image/icons/fi_copy.png",
                       height: 12.h,
                       width: 12.w,
                       color: AppColor.black0,
                     ),
                   )
                 ],
               )
                ],
              ),
            ),
            Gap(12.h),
            Container(

              height: 90.h,
              padding: EdgeInsets.only(right: 30.h),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                          width: 172.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("City:",
                                style: CustomTextStyle.kTxtMedium.copyWith(
                                    color: AppColor.black0,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w800
                                ),
                              ),
                              Row(
                                children: [
                                  Text(information!.message.details.billing.city??"no city",
                                    style: CustomTextStyle.kTxtMedium.copyWith(
                                        color: AppColor.black0,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  Gap(3.w),
                                  GestureDetector(
                                    onTap: (){
                                      copyToClipboard(
                                          context, information!.message.details.billing.city??"");
                                    },
                                    child: Image.asset(
                                      "assets/image/icons/fi_copy.png",
                                      height: 12.h,
                                      color: AppColor.black0,
                                      width: 12.w,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Gap(12.h),
                        SizedBox(
                          height: 20.h,
                          width: 172.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("State:",
                                style: CustomTextStyle.kTxtMedium.copyWith(
                                    color: AppColor.black0,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w800
                                ),
                              ),
                              Row(
                                children: [
                                  Text(information!.message.details.billing.state??"no state",
                                    style: CustomTextStyle.kTxtMedium.copyWith(
                                        color: AppColor.black0,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  Gap(3.w),
                                  GestureDetector(
                                    onTap: (){
                                      copyToClipboard(
                                          context, information!.message.details.billing.state??"");
                                    },
                                    child: Image.asset(
                                      "assets/image/icons/fi_copy.png",
                                      height: 12.h,
                                      color: AppColor.black0,
                                      width: 12.w,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Gap(12.h),
                        SizedBox(
                          height: 20.h,
                          width: 172.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Zip:",
                                style: CustomTextStyle.kTxtMedium.copyWith(
                                    color: AppColor.black0,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w800
                                ),
                              ),
                              Row(
                                children: [
                                  Text(information!.message.details.billing.postalCode??"no postal code",
                                    style: CustomTextStyle.kTxtMedium.copyWith(
                                        color: AppColor.black0,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  Gap(3.w),
                                  GestureDetector(
                                    onTap: (){
                                      copyToClipboard(
                                          context,information!.message.details.billing.postalCode??"");
                                    },
                                    child: Image.asset(
                                      "assets/image/icons/fi_copy.png",
                                      height: 12.h,
                                      color: AppColor.black0,
                                      width: 12.w,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 63.h,
                      width: 58.w,
                      padding: EdgeInsets.symmetric(vertical: 8.h,),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: Image.asset("assets/image/icons/dash_container.png").image),
                        borderRadius: BorderRadius.circular(8.r),
                       // border:Border.all(color: AppColor.black0,style: BorderStyle.solid)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("CVV",
                            style: CustomTextStyle.kTxtMedium.copyWith(
                                color: AppColor.black0,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(cardDetail!.cardCcv,
                                style: CustomTextStyle.kTxtMedium.copyWith(
                                    color: AppColor.black0,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Gap(3.w),
                              GestureDetector(
                                onTap: (){
                                  copyToClipboard(
                                      context, cardDetail!.cardCcv);
                                },
                                child: Image.asset(
                                  "assets/image/icons/fi_copy.png",
                                  height: 12.h,
                                  color: AppColor.black0,
                                  width: 12.w,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
