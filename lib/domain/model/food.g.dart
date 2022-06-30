// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      id: json['id'] as String,
      name: json['name'] as String,
      occasion: json['occasion'] as Map<String, dynamic>?,
      type: json['type'] == null
          ? null
          : FoodType.fromJson(json['type'] as Map<String, dynamic>),
      places: (json['places'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {},
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type?.toJson(),
      'occasion': instance.occasion,
      'places': instance.places,
    };
