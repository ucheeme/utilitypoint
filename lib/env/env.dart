import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env{
  @EnviedField(varName: 'API_BASE_URL_DEBUG')
  static const String baseUrlStaging = _Env.baseUrlStaging;
}