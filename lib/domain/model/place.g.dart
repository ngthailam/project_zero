// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      id: json['id'] as String,
      name: json['name'] as String,
      direction: json['direction'] as String?,
      reviews: (json['reviews'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Review.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      foods: (json['foods'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {},
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'direction': instance.direction,
      'reviews': instance.reviews.map((k, e) => MapEntry(k, e.toJson())),
      'foods': instance.foods,
    };
