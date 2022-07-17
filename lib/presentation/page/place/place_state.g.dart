// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PlaceStateCWProxy {
  PlaceState displayedPlaces(List<Place> displayedPlaces);

  PlaceState places(List<Place>? places);

  PlaceState searchKeyword(String searchKeyword);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PlaceState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PlaceState(...).copyWith(id: 12, name: "My name")
  /// ````
  PlaceState call({
    List<Place>? displayedPlaces,
    List<Place>? places,
    String? searchKeyword,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPlaceState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPlaceState.copyWith.fieldName(...)`
class _$PlaceStateCWProxyImpl implements _$PlaceStateCWProxy {
  final PlaceState _value;

  const _$PlaceStateCWProxyImpl(this._value);

  @override
  PlaceState displayedPlaces(List<Place> displayedPlaces) =>
      this(displayedPlaces: displayedPlaces);

  @override
  PlaceState places(List<Place>? places) => this(places: places);

  @override
  PlaceState searchKeyword(String searchKeyword) =>
      this(searchKeyword: searchKeyword);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PlaceState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PlaceState(...).copyWith(id: 12, name: "My name")
  /// ````
  PlaceState call({
    Object? displayedPlaces = const $CopyWithPlaceholder(),
    Object? places = const $CopyWithPlaceholder(),
    Object? searchKeyword = const $CopyWithPlaceholder(),
  }) {
    return PlaceState(
      displayedPlaces: displayedPlaces == const $CopyWithPlaceholder() ||
              displayedPlaces == null
          ? _value.displayedPlaces
          // ignore: cast_nullable_to_non_nullable
          : displayedPlaces as List<Place>,
      places: places == const $CopyWithPlaceholder()
          ? _value.places
          // ignore: cast_nullable_to_non_nullable
          : places as List<Place>?,
      searchKeyword:
          searchKeyword == const $CopyWithPlaceholder() || searchKeyword == null
              ? _value.searchKeyword
              // ignore: cast_nullable_to_non_nullable
              : searchKeyword as String,
    );
  }
}

extension $PlaceStateCopyWith on PlaceState {
  /// Returns a callable class that can be used as follows: `instanceOfPlaceState.copyWith(...)` or like so:`instanceOfPlaceState.copyWith.fieldName(...)`.
  _$PlaceStateCWProxy get copyWith => _$PlaceStateCWProxyImpl(this);
}
