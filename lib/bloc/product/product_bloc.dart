import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../model/defaultModel.dart';
import '../../model/request/getProduct.dart';
import '../../model/response/dataPlanCategory.dart';
import '../../model/response/dataPlanResponse.dart';
import '../../model/response/networksList.dart';
import '../../model/response/products.dart';
import '../../model/response/transactionHistory.dart';
import '../../repository/productsRepository.dart';
import '../../utils/app_util.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final Productsrepository productRepository;
  var errorObs = PublishSubject<String>();
  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {});
    on<GetTransactionHistoryEvent>((event,emit){
      handleGetTransactionHistory(event.request);
    });
    on<GetAllNetworkEvent>((event,emit){handleGetAllNetwork();});
    on<GetAllProductEvent>((event,emit){handleGetAllProducts();});
    on<GetAllDataProductPlanCategoryEvent>((event,emit){handleGetAllDataProductPlanCategoryEvent(event.request);});
    on<GetAllDataProductPlanEvent>((event,emit){handleGetAllDataProductPlanEvent(event.request);});
  }
  void handleGetTransactionHistory(GetProductRequest event)async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.getTransactionHistory(event);
      if (response is List<ProductTransactionList>) {
        emit(ProductTransactionHistory(response));
        AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetAllNetwork()async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.getNetwork();
      if (response is List<NetworkList>) {
        emit(ProductAllNetworks(response));
        AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetAllProducts()async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.getProduct();
      if (response is List<NetworkList>) {
        emit(ProductAllNetworks(response));
        AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetAllDataProductPlanCategoryEvent(GetProductRequest event)async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.getProductDataPlanCategory(event);
      if (response is List<DataPlanCategory>) {
        emit(AllDataProductPlanCategories(response));
        AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetAllDataProductPlanEvent(GetProductRequest event)async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.getProductPlans(event);
      if (response is  List<DataPlanResponse>) {
        emit(AllProductPlanSuccess(response));
       AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }

  initial(){
    emit(ProductInitial());
  }

}
