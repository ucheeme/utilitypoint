import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:utilitypoint/utils/height.dart';
import 'package:utilitypoint/utils/text_style.dart';

import 'app_color_constant.dart';

class CustomKeypad extends StatefulWidget {
  final TextEditingController controller;
  int? textLength;
  CustomKeypad(
      {super.key,required this.controller,this.textLength}
      );
  @override
  _CustomKeypadState createState() => _CustomKeypadState();
}

class _CustomKeypadState extends State<CustomKeypad> {


  late TextEditingController _controller;
  List<String> _keypadNumbers = [
    "1", "2", "3",
    "4", "5", "6",
    "7", "8", "9",
  ];
  var isPositionEmpty= Rx(false);

  @override
  void initState() {

    super.initState();
    _controller= widget.controller;
    // _keypadNumbers.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     width: Get.width,
      height: 390.h,
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      _input("1");
                    },
                    child: Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.black0,
                        
                          // border: Border.all(color: kBlack)
                        ),
                        child: Center(
                          child: Text(
                              "1",style: CustomTextStyle.kTxtMedium.copyWith(
                            color: AppColor.black100,fontSize: 24.sp
                          )),
                        )
                    ),
                  ),
                  Gap(28.w),
                  GestureDetector(
                    onTap: (){
                      _input("2");
                    },
                    child:Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.black0,
                        
                          // border: Border.all(color: kBlack)
                        ),
                        child: Center(
                          child: Text(
                              "2",style: CustomTextStyle.kTxtMedium.copyWith(
                              color: AppColor.black100,fontSize: 24.sp
                          )),
                        )
                    ),
                  ),
                  Gap(28.w),
                  GestureDetector(
                    onTap: (){
                      _input("3");
                    },
                    child: Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.black0,
                        
                          // border: Border.all(color: kBlack)
                        ),
                        child: Center(
                          child: Text(
                              "3",style: CustomTextStyle.kTxtMedium.copyWith(
                              color: AppColor.black100,fontSize: 24.sp
                          )),
                        )
                    ),
                  ),
                ],
              ),
            ),
            height20,
            Container(
              height: 80.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      _input("4");
                    },
                    child: Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.black0,
                        
                          // border: Border.all(color: kBlack)
                        ),
                        child: Center(
                          child: Text(
                              "4",style: CustomTextStyle.kTxtMedium.copyWith(
                              color: AppColor.black100,fontSize: 24.sp
                          )),
                        )
                    ),
                  ),
                  Gap(28.w),
                  GestureDetector(
                    onTap: (){
                      _input("5");
                    },
                    child:Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.black0,
                        
                          // border: Border.all(color: kBlack)
                        ),
                        child: Center(
                          child: Text(
                              "5",style: CustomTextStyle.kTxtMedium.copyWith(
                              color: AppColor.black100,fontSize: 24.sp
                          )),
                        )
                    ),
                  ),
                  Gap(28.w),
                  GestureDetector(
                    onTap: (){
                      _input("6");
                    },
                    child: Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.black0,
                        
                          // border: Border.all(color: kBlack)
                        ),
                        child: Center(
                          child: Text(
                              "6",style: CustomTextStyle.kTxtMedium.copyWith(
                              color: AppColor.black100,fontSize: 24.sp
                          )),
                        )
                    ),
                  ),
                ],
              ),
            ),
            height20,
            Container(
              height: 80.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      _input("7");
                    },
                    child: Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.black0,
                        
                          // border: Border.all(color: kBlack)
                        ),
                        child: Center(
                          child: Text(
                              "7",style: CustomTextStyle.kTxtMedium.copyWith(
                              color: AppColor.black100,fontSize: 24.sp
                          )),
                        )
                    ),
                  ),
                  Gap(28.w),
                  GestureDetector(
                    onTap: (){
                      _input("8");
                    },
                    child:Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.black0,
                        
                          // border: Border.all(color: kBlack)
                        ),
                        child: Center(
                          child: Text(
                              "8",style: CustomTextStyle.kTxtMedium.copyWith(
                              color: AppColor.black100,fontSize: 24.sp
                          )),
                        )
                    ),
                  ),
                  Gap(28.w),
                  GestureDetector(
                    onTap: (){
                      _input("9");
                    },
                    child: Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.black0,
                        
                          // border: Border.all(color: kBlack)
                        ),
                        child: Center(
                          child: Text(
                              "9",style: CustomTextStyle.kTxtMedium.copyWith(
                              color: AppColor.black100,fontSize: 24.sp
                          )),
                        )
                    ),
                  ),
                ],
              ),
            ),
            height20,
            Container(
              height: 80.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 80.w,),
                  Gap(28.w),
                  GestureDetector(
                    onTap: (){
                      _input("0");
                    },
                    child:  Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.black0,
                        
                          // border: Border.all(color: kBlack)
                        ),
                        child: Center(
                          child: Text(
                              "0",style: CustomTextStyle.kTxtMedium.copyWith(
                              color: AppColor.black100,fontSize: 24.sp
                          )),
                        )
                    ),
                  ),
                  Gap(28.w),
                  GestureDetector(
                    onTap: (){
                      _backspace();
                    },
                    child: Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.black0,
                        
                          // border: Border.all(color: kBlack)
                        ),
                        child: Center(
                            child:Center(
                              child: SvgPicture.asset("assets/image/icons/removeValues.svg"),
                            )
                        )
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget defaultValues(int value){

    //     if(value == 10){
    //   return Center(
    //     child: SvgPicture.asset("assets/removeValues.svg"),
    //   );
    // }else
    return Center(
      child: Text(
          _keypadNumbers[value],
         style: CustomTextStyle.kTxtMedium.copyWith(color: AppColor.black100,fontSize:  24.sp,) ),
    );
  }

  void _input(String text) {
    final value = _controller.text + text;
    int value2= widget.textLength??4;
    if(_controller.text.length!= value2){
      _controller.text = value;
      print(value);
    }
  }
  void _backspace() {
    final value = _controller.text;
    if (value.isNotEmpty) {
      _controller.text = value.substring(0, value.length - 1);
    }
  }
}
