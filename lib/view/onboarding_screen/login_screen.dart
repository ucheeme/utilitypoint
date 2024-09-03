
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/onboarding/bloc.dart';
import '../../bloc/onboarding/event.dart';
import '../../repository/onboarding_repository.dart';

class SignInPage extends StatelessWidget {
  OnboardingRepository repository = OnboardingRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OnBoardingBlocBloc(repository)..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<OnBoardingBlocBloc>(context);

    return Container();
  }
}

