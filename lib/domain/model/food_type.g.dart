// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodType _$FoodTypeFromJson(Map<String, dynamic> json) => FoodType(
      cold: json['cold'] as bool? ?? false,
      hot: json['hot'] as bool? ?? false,
      water: json['water'] as bool? ?? false,
    );

Map<String, dynamic> _$FoodTypeToJson(FoodType instance) => <String, dynamic>{
      'cold': instance.cold,
      'hot': instance.hot,
      'water': instance.water,
    };
