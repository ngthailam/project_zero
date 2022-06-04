import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/config.dart';
import 'package:de1_mobile_friends/domain/repo/config_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetConfigInteractor extends BaseInteractor<Null, Config> {
  final ConfigRepo _configRepo;

  GetConfigInteractor(this._configRepo);

  @override
  Future<Config> execute(Null input) {
    return _configRepo.getConfig();
  }
}
