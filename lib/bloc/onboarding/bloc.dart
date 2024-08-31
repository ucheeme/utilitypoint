import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class OnBoardingBlocBloc extends Bloc<OnBoardingBlocEvent, OnBoardingBlocState> {
  OnBoardingBlocBloc() : super(OnBoardingBlocState().init());

  @override
  Stream<OnBoardingBlocState> mapEventToState(OnBoardingBlocEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }
  }

  Future<OnBoardingBlocState> init() async {
    return state.clone();
  }
}
