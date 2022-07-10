// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FoodCWProxy {
  Food categories(Map<String, bool>? categories);

  Food id(String id);

  Food name(String name);

  Food occasion(Map<String, dynamic>? occasion);

  Food placeList(List<Place> placeList);

  Food places(Map<String, bool> places);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Food(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Food(...).copyWith(id: 12, name: "My name")
  /// ````
  Food call({
    Map<String, bool>? categories,
    String? id,
    String? name,
    Map<String, dynamic>? occasion,
    List<Place>? placeList,
    Map<String, bool>? places,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFood.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFood.copyWith.fieldName(...)`
class _$FoodCWProxyImpl implements _$FoodCWProxy {
  final Food _value;

  const _$FoodCWProxyImpl(this._value);

  @override
  Food categories(Map<String, bool>? categories) =>
      this(categories: categories);

  @override
  Food id(String id) => this(id: id);

  @override
  Food name(String name) => this(name: name);

  @override
  Food occasion(Map<String, dynamic>? occasion) => this(occasion: occasion);

  @override
  Food placeList(List<Place> placeList) => this(placeList: placeList);

  @override
  Food places(Map<String, bool> places) => this(places: places);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Food(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Food(...).copyWith(id: 12, name: "My name")
  /// ````
  Food call({
    Object? categories = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? occasion = const $CopyWithPlaceholder(),
    Object? placeList = const $CopyWithPlaceholder(),
    Object? places = const $CopyWithPlaceholder(),
  }) {
    return Food(
      categories: categories == const $CopyWithPlaceholder()
          ? _value.categories
          // ignore: cast_nullable_to_non_nullable
          : categories as Map<String, bool>?,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      occasion: occasion == const $CopyWithPlaceholder()
          ? _value.occasion
          // ignore: cast_nullable_to_non_nullable
          : occasion as Map<String, dynamic>?,
      placeList: placeList == const $CopyWithPlaceholder() || placeList == null
          ? _value.placeList
          // ignore: cast_nullable_to_non_nullable
          : placeList as List<Place>,
      places: places == const $CopyWithPlaceholder() || places == null
          ? _value.places
          // ignore: cast_nullable_to_non_nullable
          : places as Map<String, bool>,
    );
  }
}

extension $FoodCopyWith on Food {
  /// Returns a callable class that can be used as follows: `instanceOfFood.copyWith(...)` or like so:`instanceOfFood.copyWith.fieldName(...)`.
  _$FoodCWProxy get copyWith => _$FoodCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      id: json['id'] as String,
      name: json['name'] as String,
      occasion: json['occasion'] as Map<String, dynamic>?,
      places: (json['places'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {},
      categories: (json['categories'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {},
      placeList: (json['placeList'] as List<dynamic>?)
              ?.map((e) => Place.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'occasion': instance.occasion,
      'places': instance.places,
      'placeList': instance.placeList.map((e) => e.toJson()).toList(),
      'categories': instance.categories,
    };
