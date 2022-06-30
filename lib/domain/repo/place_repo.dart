import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/domain/model/review.dart';

abstract class PlaceRepo {
  initialize();

  Stream<List<Place>> observePlaces();

  dispose();

  Future<void> addPlace(Place place);

  Future<List<Place>> getPlaces();

  deletePlace(String id);

  Stream<Place?> observeOnePlace(String input);

  Future<Place> getPlace(String id);

  Future<void> addReview(Review review);

  Future<bool> addFoodInPlace({
    required String foodId,
    required String placeId,
  });

  Future<bool> removeFoodInPlace({
    required String foodId,
    required String placeId,
  });
}
