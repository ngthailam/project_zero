// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  WeatherModel({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
  });

  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final Current current;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        lat: (json['lat'] ?? 0.0).toDouble(),
        lon: (json['lon'] ?? 0.0).toDouble(),
        timezone: json['timezone'] ?? '',
        timezoneOffset: json['timezone_offset'] ?? 0,
        current: Current.fromJson(json['current'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
        'timezone': timezone,
        'timezone_offset': timezoneOffset,
        'current': current.toJson(),
      };
}

class Current {
  Current({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
  });

  final int dt;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final double windGust;
  final List<Weather> weather;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json['dt'] ?? 0,
        sunrise: json['sunrise'] ?? 0,
        sunset: json['sunset'] ?? 0,
        temp: (json['temp'] ?? 0.0).toDouble(),
        feelsLike: (json['feelsLike'] ?? 0.0).toDouble(),
        pressure: json['pressure'] ?? 0,
        humidity: json['humidity'] ?? 0,
        dewPoint: (json['dewPoint'] ?? 0.0).toDouble(),
        uvi: (json['uvi'] ?? 0.0).toDouble(),
        clouds: json['clouds'] ?? 0,
        visibility: json['visibility'] ?? 0,
        windSpeed: (json['windSpeed'] ?? 0.0).toDouble(),
        windDeg: json['wind_deg'] ?? 0,
        windGust: (json['windGust'] ?? 0.0).toDouble(),
        weather: json['weather'] == null
            ? []
            : List<Weather>.from(
                json['weather'].map((x) => Weather.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'sunrise': sunrise,
        'sunset': sunset,
        'temp': temp,
        'feels_like': feelsLike,
        'pressure': pressure,
        'humidity': humidity,
        'dew_point': dewPoint,
        'uvi': uvi,
        'clouds': clouds,
        'visibility': visibility,
        'wind_speed': windSpeed,
        'wind_deg': windDeg,
        'wind_gust': windGust,
        'weather': List<dynamic>.from(weather.map((x) => x.toJson())),
      };
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int id;
  final String main;
  final String description;
  final String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'] ?? 0,
        main: json['main'] ?? '',
        description: json['description'] ?? '',
        icon: json['icon'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}
