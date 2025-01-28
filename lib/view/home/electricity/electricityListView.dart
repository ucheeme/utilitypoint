import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:utilitypoint/utils/constant.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../model/request/getProduct.dart';
import '../../../model/response/dataPlanCategory.dart';
import '../../../utils/app_color_constant.dart';
import '../../../utils/customAnimation.dart';
import '../../../utils/image_paths.dart';
import '../../../utils/reuseable_widget.dart';
import '../cable/cableListView.dart';
import '../cable/cableSelectionPlan.dart';
import 'electricListViewCompanies.dart';

class ElectricityListView extends StatefulWidget {
  ElectricityListView({super.key});

  @override
  State<ElectricityListView> createState() => _ElectricityListViewState();
}

class _ElectricityListViewState extends State<ElectricityListView> with TickerProviderStateMixin {
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
          productSlug: "utility_bills"
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
                  child: CustomAppBar(title: "Electricity")),
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
                            //Get.to(CableTvSelection(productPlanCategoryItem: element,));
                            Get.to(ElectricityListCompanies(productCategoryId: element.id,
                                meterType:element.productPlanCategoryName
                            ));
                          },
                          child: listButtons(title: element.productPlanCategoryName,
                              icons: getCableLogo(element.productPlanCategoryName)
                          )
                      )
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
