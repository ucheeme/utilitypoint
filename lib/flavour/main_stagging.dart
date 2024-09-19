import '../env/env.dart';
import '../main.dart';
import 'flavour.dart';

Future<void> main() async {
  final devConfig = AppFlavorConfig(
    name: 'Staging',
    apiBaseUrl: Env.baseUrlStaging,
  );
  mainCommon(devConfig);
}