// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_place_in_food_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddPlaceInFoodStateCWProxy {
  AddPlaceInFoodState addPlaceLoadState(LoadState addPlaceLoadState);

  AddPlaceInFoodState places(List<Place>? places);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddPlaceInFoodState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddPlaceInFoodState(...).copyWith(id: 12, name: "My name")
  /// ````
  AddPlaceInFoodState call({
    LoadState? addPlaceLoadState,
    List<Place>? places,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddPlaceInFoodState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddPlaceInFoodState.copyWith.fieldName(...)`
class _$AddPlaceInFoodStateCWProxyImpl implements _$AddPlaceInFoodStateCWProxy {
  final AddPlaceInFoodState _value;

  const _$AddPlaceInFoodStateCWProxyImpl(this._value);

  @override
  AddPlaceInFoodState addPlaceLoadState(LoadState addPlaceLoadState) =>
      this(addPlaceLoadState: addPlaceLoadState);

  @override
  AddPlaceInFoodState places(List<Place>? places) => this(places: places);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddPlaceInFoodState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddPlaceInFoodState(...).copyWith(id: 12, name: "My name")
  /// ````
  AddPlaceInFoodState call({
    Object? addPlaceLoadState = const $CopyWithPlaceholder(),
    Object? places = const $CopyWithPlaceholder(),
  }) {
    return AddPlaceInFoodState(
      addPlaceLoadState: addPlaceLoadState == const $CopyWithPlaceholder() ||
              addPlaceLoadState == null
          ? _value.addPlaceLoadState
          // ignore: cast_nullable_to_non_nullable
          : addPlaceLoadState as LoadState,
      places: places == const $CopyWithPlaceholder()
          ? _value.places
          // ignore: cast_nullable_to_non_nullable
          : places as List<Place>?,
    );
  }
}

extension $AddPlaceInFoodStateCopyWith on AddPlaceInFoodState {
  /// Returns a callable class that can be used as follows: `instanceOfAddPlaceInFoodState.copyWith(...)` or like so:`instanceOfAddPlaceInFoodState.copyWith.fieldName(...)`.
  _$AddPlaceInFoodStateCWProxy get copyWith =>
      _$AddPlaceInFoodStateCWProxyImpl(this);
}
