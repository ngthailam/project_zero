import 'package:de1_mobile_friends/domain/model/config.dart';

abstract class ConfigRepo {
  Future<Config> getConfig();
}
