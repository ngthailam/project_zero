import 'dart:async';

import 'package:de1_mobile_friends/data/food/food_local_datasource.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:injectable/injectable.dart';
import 'package:collection/collection.dart';

abstract class PlaceLocalDataSource {
  void savePlaces(List<Place> places);

  Stream<List<Place>> observePlaces();

  List<Place> getPlaces();

  Place? getPlace(String id);
}

@Singleton(as: PlaceLocalDataSource)
class PlaceLocalDataSourceImpl extends PlaceLocalDataSource {
  final StreamController<List<Place>> placesStreamCtrl =
      StreamController.broadcast();

  List<Place> _currentPlaces = [];

  // TODO: circular dependencies
  final FoodLocalDataSource _foodLocalDataSource;

  PlaceLocalDataSourceImpl(this._foodLocalDataSource);

  @override
  List<Place> getPlaces() {
    final foods = _foodLocalDataSource.getFoods();
    return _currentPlaces.map((e) => e.withFoods(foods)).toList();
  }

  @override
  Place? getPlace(String id) {
    final foods = _foodLocalDataSource.getFoods();

    final place =
        _currentPlaces.firstWhereOrNull((element) => element.id == id);
    return place?.withFoods(foods);
  }

  @override
  Stream<List<Place>> observePlaces() {
    final foods = _foodLocalDataSource.getFoods();
    return placesStreamCtrl.stream.map((List<Place> event) {
      return event.map((e) => e.withFoods(foods)).toList();
    });
  }

  @override
  void savePlaces(List<Place> places) {
    _currentPlaces = places;
    placesStreamCtrl.add(_currentPlaces);
  }
}
