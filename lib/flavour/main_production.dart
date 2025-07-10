import '../env/env.dart';
import '../main.dart';
import 'flavour.dart';

Future<void> main() async {
  final devConfig = AppFlavorConfig(
    name: 'Production',
    apiBaseUrl: Env.baseUrlProduction,
  );
  mainCommon(devConfig);
}