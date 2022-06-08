import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/either.dart';
import 'package:de1_mobile_friends/domain/model/food_type.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:de1_mobile_friends/domain/repo/weather_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddTempInteractor
    extends BaseInteractor<double, Either<bool, Exception>> {
  final WeatherRepo _weatherRepo;

  AddTempInteractor(this._weatherRepo);

  @override
  Future<Either<bool, Exception>> execute(double temp) async {
    try {
      final result = await _weatherRepo.addTempCurrent(
        temp,
      );
      return Either(data: result);
    } on Exception catch (e) {
      return Either(exception: e);
    }
  }
}
