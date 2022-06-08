import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/food_type.dart';
import 'package:de1_mobile_friends/domain/model/temp_model.dart';
import 'package:de1_mobile_friends/domain/model/weather_model.dart';

abstract class WeatherRepo {
  Future<WeatherModel> getWeatherCurrent();
  Future<bool> addTempCurrent(double temp);
  Future<bool> addWeatherCurrent(Weather weather);
}
