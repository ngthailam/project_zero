import 'package:de1_mobile_friends/domain/model/config.dart';
import 'package:de1_mobile_friends/domain/repo/config_repo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ConfigRepo)
class ConfigRepoImpl extends ConfigRepo {
  @override
  Future<Config> getConfig() async {
    final ref = FirebaseDatabase.instance.ref("config/temp");

    final snapshot = await ref.get();
    return Config.fromJson(snapshot.value as Map<String, dynamic>);
  }
}
