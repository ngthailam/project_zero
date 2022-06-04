// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      rain: json['rain'] as String?,
      temp: (json['temp'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'rain': instance.rain,
      'temp': instance.temp,
    };
