// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PlaceCWProxy {
  Place direction(String? direction);

  Place foodList(List<Food> foodList);

  Place foods(Map<String, bool> foods);

  Place id(String id);

  Place name(String name);

  Place reviews(Map<String, Review> reviews);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Place(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Place(...).copyWith(id: 12, name: "My name")
  /// ````
  Place call({
    String? direction,
    List<Food>? foodList,
    Map<String, bool>? foods,
    String? id,
    String? name,
    Map<String, Review>? reviews,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPlace.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPlace.copyWith.fieldName(...)`
class _$PlaceCWProxyImpl implements _$PlaceCWProxy {
  final Place _value;

  const _$PlaceCWProxyImpl(this._value);

  @override
  Place direction(String? direction) => this(direction: direction);

  @override
  Place foodList(List<Food> foodList) => this(foodList: foodList);

  @override
  Place foods(Map<String, bool> foods) => this(foods: foods);

  @override
  Place id(String id) => this(id: id);

  @override
  Place name(String name) => this(name: name);

  @override
  Place reviews(Map<String, Review> reviews) => this(reviews: reviews);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Place(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Place(...).copyWith(id: 12, name: "My name")
  /// ````
  Place call({
    Object? direction = const $CopyWithPlaceholder(),
    Object? foodList = const $CopyWithPlaceholder(),
    Object? foods = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? reviews = const $CopyWithPlaceholder(),
  }) {
    return Place(
      direction: direction == const $CopyWithPlaceholder()
          ? _value.direction
          // ignore: cast_nullable_to_non_nullable
          : direction as String?,
      foodList: foodList == const $CopyWithPlaceholder() || foodList == null
          ? _value.foodList
          // ignore: cast_nullable_to_non_nullable
          : foodList as List<Food>,
      foods: foods == const $CopyWithPlaceholder() || foods == null
          ? _value.foods
          // ignore: cast_nullable_to_non_nullable
          : foods as Map<String, bool>,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      reviews: reviews == const $CopyWithPlaceholder() || reviews == null
          ? _value.reviews
          // ignore: cast_nullable_to_non_nullable
          : reviews as Map<String, Review>,
    );
  }
}

extension $PlaceCopyWith on Place {
  /// Returns a callable class that can be used as follows: `instanceOfPlace.copyWith(...)` or like so:`instanceOfPlace.copyWith.fieldName(...)`.
  _$PlaceCWProxy get copyWith => _$PlaceCWProxyImpl(this);
}

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
      foodList: (json['foodList'] as List<dynamic>?)
              ?.map((e) => Food.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'direction': instance.direction,
      'reviews': instance.reviews.map((k, e) => MapEntry(k, e.toJson())),
      'foods': instance.foods,
      'foodList': instance.foodList.map((e) => e.toJson()).toList(),
    };
