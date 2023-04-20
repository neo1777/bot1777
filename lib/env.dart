import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'secretkey', obfuscate: true)
  static String secretkey = _Env.secretkey;
  @EnviedField(varName: 'apikey', obfuscate: true)
  static String apikey = _Env.apikey;
}
