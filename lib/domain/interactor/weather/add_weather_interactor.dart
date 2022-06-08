import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/either.dart';
import 'package:de1_mobile_friends/domain/model/food_type.dart';
import 'package:de1_mobile_friends/domain/model/weather_model.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:de1_mobile_friends/domain/repo/weather_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddWeatherInteractor
    extends BaseInteractor<Weather, Either<bool, Exception>> {
  final WeatherRepo _weatherRepo;

  AddWeatherInteractor(this._weatherRepo);

  @override
  Future<Either<bool, Exception>> execute(Weather weather) async {
    try {
      final result = await _weatherRepo.addWeatherCurrent(weather);
      return Either(data: result);
    } on Exception catch (e) {
      return Either(exception: e);
    }
  }
}
