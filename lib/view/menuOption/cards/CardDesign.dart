import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:utilitypoint/utils/image_paths.dart';

import '../../../model/response/listofVirtualCard.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/text_style.dart';

class CardDesign extends StatefulWidget {
  UserVirtualCards? cardDetail;
   CardDesign({super.key,this.cardDetail});

  @override
  State<CardDesign> createState() => _CardDesignState();
}

class _CardDesignState extends State<CardDesign> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 164.h,
        width: 335.w,
        margin: EdgeInsets.symmetric(vertical: 16.h),
        padding: EdgeInsets.symmetric(vertical: 20.h,),
        decoration: BoxDecoration(
           color: AppColor.black100,
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
                          color: widget.cardDetail!.brand=="MASTERCARD"?AppColor.black10:AppColor.visaCard,
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
           height:83.h,
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
                       height:31.h,
                       width: 277.w,
                       child: Text("**** ****  **** ${widget.cardDetail!.cardLastFour}",
                         style:  GoogleFonts.inter(
                             color: AppColor.black0,
                             fontWeight: FontWeight.w700,
                             fontSize: 26.sp
                         ),),
                     ),
                     Gap(21.5.h),
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
      );
  }
}
