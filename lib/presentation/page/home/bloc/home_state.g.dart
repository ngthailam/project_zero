// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HomeStateCWProxy {
  HomeState displayedFoods(List<Food>? displayedFoods);

  HomeState foods(List<Food>? foods);

  HomeState occasions(Occasion? occasions);

  HomeState pickedFoodIndex(int? pickedFoodIndex);

  HomeState pickedOccasionKey(String? pickedOccasionKey);

  HomeState spinStatus(HomeSpinStatus spinStatus);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeState call({
    List<Food>? displayedFoods,
    List<Food>? foods,
    Occasion? occasions,
    int? pickedFoodIndex,
    String? pickedOccasionKey,
    HomeSpinStatus? spinStatus,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHomeState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHomeState.copyWith.fieldName(...)`
class _$HomeStateCWProxyImpl implements _$HomeStateCWProxy {
  final HomeState _value;

  const _$HomeStateCWProxyImpl(this._value);

  @override
  HomeState displayedFoods(List<Food>? displayedFoods) =>
      this(displayedFoods: displayedFoods);

  @override
  HomeState foods(List<Food>? foods) => this(foods: foods);

  @override
  HomeState occasions(Occasion? occasions) => this(occasions: occasions);

  @override
  HomeState pickedFoodIndex(int? pickedFoodIndex) =>
      this(pickedFoodIndex: pickedFoodIndex);

  @override
  HomeState pickedOccasionKey(String? pickedOccasionKey) =>
      this(pickedOccasionKey: pickedOccasionKey);

  @override
  HomeState spinStatus(HomeSpinStatus spinStatus) =>
      this(spinStatus: spinStatus);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeState call({
    Object? displayedFoods = const $CopyWithPlaceholder(),
    Object? foods = const $CopyWithPlaceholder(),
    Object? occasions = const $CopyWithPlaceholder(),
    Object? pickedFoodIndex = const $CopyWithPlaceholder(),
    Object? pickedOccasionKey = const $CopyWithPlaceholder(),
    Object? spinStatus = const $CopyWithPlaceholder(),
  }) {
    return HomeState(
      displayedFoods: displayedFoods == const $CopyWithPlaceholder()
          ? _value.displayedFoods
          // ignore: cast_nullable_to_non_nullable
          : displayedFoods as List<Food>?,
      foods: foods == const $CopyWithPlaceholder()
          ? _value.foods
          // ignore: cast_nullable_to_non_nullable
          : foods as List<Food>?,
      occasions: occasions == const $CopyWithPlaceholder()
          ? _value.occasions
          // ignore: cast_nullable_to_non_nullable
          : occasions as Occasion?,
      pickedFoodIndex: pickedFoodIndex == const $CopyWithPlaceholder()
          ? _value.pickedFoodIndex
          // ignore: cast_nullable_to_non_nullable
          : pickedFoodIndex as int?,
      pickedOccasionKey: pickedOccasionKey == const $CopyWithPlaceholder()
          ? _value.pickedOccasionKey
          // ignore: cast_nullable_to_non_nullable
          : pickedOccasionKey as String?,
      spinStatus:
          spinStatus == const $CopyWithPlaceholder() || spinStatus == null
              ? _value.spinStatus
              // ignore: cast_nullable_to_non_nullable
              : spinStatus as HomeSpinStatus,
    );
  }
}

extension $HomeStateCopyWith on HomeState {
  /// Returns a callable class that can be used as follows: `instanceOfHomeState.copyWith(...)` or like so:`instanceOfHomeState.copyWith.fieldName(...)`.
  _$HomeStateCWProxy get copyWith => _$HomeStateCWProxyImpl(this);
}
