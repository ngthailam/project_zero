import 'dart:convert';

import 'package:de1_mobile_friends/data/client/weather_client.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/food_type.dart';
import 'package:de1_mobile_friends/domain/model/temp_model.dart';
import 'package:de1_mobile_friends/domain/model/weather_model.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:de1_mobile_friends/domain/repo/weather_repo.dart';
import 'package:de1_mobile_friends/main.dart';
import 'package:de1_mobile_friends/uuid_generator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WeatherRepo)
class WeatherRepoImpl extends WeatherRepo {
  @override
  Future<WeatherModel> getWeatherCurrent() async {
    try {
      final ref = await getIt<WeatherClient>().getWeatherCurrent();

      return ref;
    } catch (e) {
      return WeatherModel.fromJson({});
    }
  }

  @override
  Future<bool> addTempCurrent(double temp) async {
    FirebaseDatabase firebase = FirebaseDatabase.instance;
    DatabaseReference ref = firebase.ref("config/temp/");
    await ref.set({"temp": temp});
    return true;
  }

  @override
  Future<bool> addWeatherCurrent(Weather weather) async {
    FirebaseDatabase firebase = FirebaseDatabase.instance;
    DatabaseReference ref = firebase.ref("config/weather/");
    await ref.set(weather.toJson());
    return true;
  }
}
