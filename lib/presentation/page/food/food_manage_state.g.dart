// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_manage_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FoodManageStateCWProxy {
  FoodManageState displayedFoods(Map<String, List<Food>> displayedFoods);

  FoodManageState foods(List<Food>? foods);

  FoodManageState occasion(Occasion? occasion);

  FoodManageState searchKeyword(String searchKeyword);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FoodManageState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FoodManageState(...).copyWith(id: 12, name: "My name")
  /// ````
  FoodManageState call({
    Map<String, List<Food>>? displayedFoods,
    List<Food>? foods,
    Occasion? occasion,
    String? searchKeyword,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFoodManageState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFoodManageState.copyWith.fieldName(...)`
class _$FoodManageStateCWProxyImpl implements _$FoodManageStateCWProxy {
  final FoodManageState _value;

  const _$FoodManageStateCWProxyImpl(this._value);

  @override
  FoodManageState displayedFoods(Map<String, List<Food>> displayedFoods) =>
      this(displayedFoods: displayedFoods);

  @override
  FoodManageState foods(List<Food>? foods) => this(foods: foods);

  @override
  FoodManageState occasion(Occasion? occasion) => this(occasion: occasion);

  @override
  FoodManageState searchKeyword(String searchKeyword) =>
      this(searchKeyword: searchKeyword);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FoodManageState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FoodManageState(...).copyWith(id: 12, name: "My name")
  /// ````
  FoodManageState call({
    Object? displayedFoods = const $CopyWithPlaceholder(),
    Object? foods = const $CopyWithPlaceholder(),
    Object? occasion = const $CopyWithPlaceholder(),
    Object? searchKeyword = const $CopyWithPlaceholder(),
  }) {
    return FoodManageState(
      displayedFoods: displayedFoods == const $CopyWithPlaceholder() ||
              displayedFoods == null
          ? _value.displayedFoods
          // ignore: cast_nullable_to_non_nullable
          : displayedFoods as Map<String, List<Food>>,
      foods: foods == const $CopyWithPlaceholder()
          ? _value.foods
          // ignore: cast_nullable_to_non_nullable
          : foods as List<Food>?,
      occasion: occasion == const $CopyWithPlaceholder()
          ? _value.occasion
          // ignore: cast_nullable_to_non_nullable
          : occasion as Occasion?,
      searchKeyword:
          searchKeyword == const $CopyWithPlaceholder() || searchKeyword == null
              ? _value.searchKeyword
              // ignore: cast_nullable_to_non_nullable
              : searchKeyword as String,
    );
  }
}

extension $FoodManageStateCopyWith on FoodManageState {
  /// Returns a callable class that can be used as follows: `instanceOfFoodManageState.copyWith(...)` or like so:`instanceOfFoodManageState.copyWith.fieldName(...)`.
  _$FoodManageStateCWProxy get copyWith => _$FoodManageStateCWProxyImpl(this);
}
