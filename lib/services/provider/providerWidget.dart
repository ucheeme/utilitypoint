import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:utilitypoint/bloc/card/virtualcard_bloc.dart';
import 'package:utilitypoint/bloc/product/product_bloc.dart';
import 'package:utilitypoint/bloc/profile/profile_bloc.dart';
import 'package:utilitypoint/repository/card_repository.dart';
import 'package:utilitypoint/repository/profileRepository.dart';


import '../../bloc/onboarding_new/onboard_new_bloc.dart';
import '../../repository/onboarding_repository.dart';
import '../../repository/productsRepository.dart';

class ProviderWidget{
  static List<SingleChildWidget>blocProviders(){
    return [
       ChangeNotifierProvider<NavItemProvider>(create: (_) => NavItemProvider()),
      BlocProvider(
          create: (BuildContext context)=>
              OnboardNewBloc(onboardingRepository: OnboardingRepository(),)
      ),
      BlocProvider(
          create: (BuildContext context)=>
             VirtualcardBloc(cardRepository: CardRepository(),)
      ),
      BlocProvider(
          create: (BuildContext context)=>
              ProductBloc(Productsrepository())
      ),
      BlocProvider(
          create: (BuildContext context)=>
              ProfileBloc(profileRepository: ProfileRepository())
      ),
    ];
  }
}
class NavItemProvider extends ChangeNotifier{
  int selectedIndex = 0;
  void onItemTap(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}