import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../repository/onboarding_repository.dart';
import 'event.dart';
import 'onBoardingValidator.dart';
import 'state.dart';

class OnBoardingBlocBloc extends Bloc<OnBoardingBlocEvent, OnBoardingBlocState> {
  final OnboardingRepository onboardingRepository;
  var errorObs = PublishSubject<String>();
  OnboardingFormValidation validation = OnboardingFormValidation();
  OnBoardingBlocBloc(this.onboardingRepository) : super(OnBoardingBlocState().init());

  Stream<OnBoardingBlocState> mapEventToState(OnBoardingBlocEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }

  }

  Future<OnBoardingBlocState> init() async {
    return state.clone();
  }
}
