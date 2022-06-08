import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/weather_model.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:de1_mobile_friends/domain/repo/weather_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWeatherInteractor extends BaseInteractor<void, WeatherModel> {
  final WeatherRepo _weatherRepo;

  GetWeatherInteractor(this._weatherRepo);

  @override
  Future<WeatherModel> execute(void input) {
    return _weatherRepo.getWeatherCurrent();
  }
}
