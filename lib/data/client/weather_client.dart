import 'package:de1_mobile_friends/data/client/contanst.dart';
import 'package:de1_mobile_friends/data/config_client/dio_client.dart';
import 'package:de1_mobile_friends/domain/model/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'weather_client.g.dart';

@RestApi(
  baseUrl:
      "https://api.openweathermap.org/data/2.5/onecall?lat=$valueLat&lon=$valueLong&exclude=hourly,daily&appid=$apiKeyWeather",
)
abstract class WeatherClient {

  factory WeatherClient(Dio dio) = _WeatherClient;

  @GET('')
  Future<WeatherModel> getWeatherCurrent();
}

@module
abstract class RegisterModuleX {
   WeatherClient getService(DioClient client) => _WeatherClient(client.dio);
}