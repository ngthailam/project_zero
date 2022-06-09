import 'package:de1_mobile_friends/domain/model/place.dart';

abstract class PlaceRepo {
  initialize();

  Stream<List<Place>> observePlaces();

  dispose();

  Future<void> addPlace(Place place);

  Future<List<Place>> getPlaces();
}
