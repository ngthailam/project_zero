import 'dart:async';

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

  @override
  List<Place> getPlaces() {
    return _currentPlaces;
  }

  @override
  Place? getPlace(String id) {
    return _currentPlaces.firstWhereOrNull((element) => element.id == id);
  }

  @override
  Stream<List<Place>> observePlaces() {
    return placesStreamCtrl.stream;
  }

  @override
  void savePlaces(List<Place> places) {
    _currentPlaces = places;
    placesStreamCtrl.add(_currentPlaces);
  }
}
