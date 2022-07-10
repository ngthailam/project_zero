// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_food_in_place_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddFoodInPlaceStateCWProxy {
  AddFoodInPlaceState addFoodLoadState(LoadState addFoodLoadState);

  AddFoodInPlaceState foods(List<Food>? foods);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddFoodInPlaceState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddFoodInPlaceState(...).copyWith(id: 12, name: "My name")
  /// ````
  AddFoodInPlaceState call({
    LoadState? addFoodLoadState,
    List<Food>? foods,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddFoodInPlaceState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddFoodInPlaceState.copyWith.fieldName(...)`
class _$AddFoodInPlaceStateCWProxyImpl implements _$AddFoodInPlaceStateCWProxy {
  final AddFoodInPlaceState _value;

  const _$AddFoodInPlaceStateCWProxyImpl(this._value);

  @override
  AddFoodInPlaceState addFoodLoadState(LoadState addFoodLoadState) =>
      this(addFoodLoadState: addFoodLoadState);

  @override
  AddFoodInPlaceState foods(List<Food>? foods) => this(foods: foods);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddFoodInPlaceState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddFoodInPlaceState(...).copyWith(id: 12, name: "My name")
  /// ````
  AddFoodInPlaceState call({
    Object? addFoodLoadState = const $CopyWithPlaceholder(),
    Object? foods = const $CopyWithPlaceholder(),
  }) {
    return AddFoodInPlaceState(
      addFoodLoadState: addFoodLoadState == const $CopyWithPlaceholder() ||
              addFoodLoadState == null
          ? _value.addFoodLoadState
          // ignore: cast_nullable_to_non_nullable
          : addFoodLoadState as LoadState,
      foods: foods == const $CopyWithPlaceholder()
          ? _value.foods
          // ignore: cast_nullable_to_non_nullable
          : foods as List<Food>?,
    );
  }
}

extension $AddFoodInPlaceStateCopyWith on AddFoodInPlaceState {
  /// Returns a callable class that can be used as follows: `instanceOfAddFoodInPlaceState.copyWith(...)` or like so:`instanceOfAddFoodInPlaceState.copyWith.fieldName(...)`.
  _$AddFoodInPlaceStateCWProxy get copyWith =>
      _$AddFoodInPlaceStateCWProxyImpl(this);
}
