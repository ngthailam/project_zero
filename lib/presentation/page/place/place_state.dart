import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';

abstract class PlaceState {
  final List<Place>? places;

  PlaceState(this.places);
}

class PlacePrimaryState extends PlaceState {
  PlacePrimaryState({List<Place>? places}) : super(places);
}

class PlaceFoodSearchingState extends PlaceState {
  final String keyword;
  final List<Food>? searchResults;

  PlaceFoodSearchingState({
    List<Place>? places,
    required this.keyword,
    this.searchResults,
  }) : super(places);
}

class PlaceErrorState extends PlaceState {
  final Exception e;

  PlaceErrorState({required this.e, List<Place>? places}) : super(places);
}
