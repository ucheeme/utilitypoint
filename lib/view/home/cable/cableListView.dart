import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/bloc/product/product_bloc.dart';
import 'package:utilitypoint/utils/constant.dart';

import '../../../model/request/getProduct.dart';
import '../../../model/response/dataPlanCategory.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/image_paths.dart';
import '../../../utils/reuseable_widget.dart';
import 'cableSelectionPlan.dart';

class CableListView extends StatefulWidget {
   CableListView({super.key});

  @override
  State<CableListView> createState() => _CableListViewState();
}

class _CableListViewState extends State<CableListView> with TickerProviderStateMixin {
  late SlideAnimationManager _animationManager;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  List<ProductPlanCategoryItem> productPlanCategoryList=[];
  TextEditingController phoneNumber = TextEditingController();
  late ProductBloc bloc;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      bloc.add(GetAllProductPlanCategoryEvent(GetProductRequest(
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
        if (state is AllProductPlanCategories){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            productPlanCategoryList= state.response;
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
                children: [
                  SizedBox(
                      height: 41.h,
                      child: SearchTransactionHistory(
                        hintTxt: "Search Provider",
                        surffixWidget: Container(
                            height:20.h ,
                            width: 20.w,
                            padding: EdgeInsets.all(8.h),
                            child: Image.asset(search_Image,height: 14.h,width: 14.w,)),
                      )),
                  ...productPlanCategoryList.mapIndexed((element, index)=>
                  GestureDetector(
                      onTap: (){
                      Get.to(CableTvSelection(productPlanCategoryItem: element,));
                      },
                      child: listButtons(title: element.productPlanCategoryName,icons: getCableLogo(element.productPlanCategoryName)))
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

String getCableLogo(String title){
  print(title);
  switch(title){
    case "GOTV": return "gotv_Icon";
    case "STARTIMES": return "startimes_Icon";
    case "DSTV": return "dstv_Icon";
    case "SHOWMAX": return "showmax_Icon";
    case "ABUJA": return "abujaElectric_Icon";
    case "BENIN": return "benin_Icon";
    case "EKO": return "eko_Icon";
    case "ENUGU": return "enugu_Icon";
    case "IBADAN": return "ibadan_Icon";
    case "IKEJA": return "ikeja_Icon";
    case "JOS": return "jos_Icon";
    case "KADUNA": return "kaduna_Icon";
    case "KANO": return "kano_Icon";
    case "PORT HACOURTH": return "pH_Icon";
    case "YOLA": return "yola_Icon";
    default: return "";
  }
}