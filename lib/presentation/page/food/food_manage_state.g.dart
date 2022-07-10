// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_manage_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FoodManageStateCWProxy {
  FoodManageState foodInCategories(Map<String, List<Food>> foodInCategories);

  FoodManageState occasion(Occasion? occasion);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FoodManageState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FoodManageState(...).copyWith(id: 12, name: "My name")
  /// ````
  FoodManageState call({
    Map<String, List<Food>>? foodInCategories,
    Occasion? occasion,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFoodManageState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFoodManageState.copyWith.fieldName(...)`
class _$FoodManageStateCWProxyImpl implements _$FoodManageStateCWProxy {
  final FoodManageState _value;

  const _$FoodManageStateCWProxyImpl(this._value);

  @override
  FoodManageState foodInCategories(Map<String, List<Food>> foodInCategories) =>
      this(foodInCategories: foodInCategories);

  @override
  FoodManageState occasion(Occasion? occasion) => this(occasion: occasion);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FoodManageState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FoodManageState(...).copyWith(id: 12, name: "My name")
  /// ````
  FoodManageState call({
    Object? foodInCategories = const $CopyWithPlaceholder(),
    Object? occasion = const $CopyWithPlaceholder(),
  }) {
    return FoodManageState(
      foodInCategories: foodInCategories == const $CopyWithPlaceholder() ||
              foodInCategories == null
          ? _value.foodInCategories
          // ignore: cast_nullable_to_non_nullable
          : foodInCategories as Map<String, List<Food>>,
      occasion: occasion == const $CopyWithPlaceholder()
          ? _value.occasion
          // ignore: cast_nullable_to_non_nullable
          : occasion as Occasion?,
    );
  }
}

extension $FoodManageStateCopyWith on FoodManageState {
  /// Returns a callable class that can be used as follows: `instanceOfFoodManageState.copyWith(...)` or like so:`instanceOfFoodManageState.copyWith.fieldName(...)`.
  _$FoodManageStateCWProxy get copyWith => _$FoodManageStateCWProxyImpl(this);
}
