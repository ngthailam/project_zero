import 'dart:async';

import 'package:de1_mobile_friends/data/food/food_local_datasource.dart';
import 'package:de1_mobile_friends/data/food/food_remote_datasource.dart';
import 'package:de1_mobile_friends/data/place/place_local_datasource.dart';
import 'package:de1_mobile_friends/data/place/place_remote_datasource.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/domain/model/review.dart';
import 'package:de1_mobile_friends/domain/repo/place_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:collection/collection.dart';

@Singleton(as: PlaceRepo)
class PlaceRepoImpl extends PlaceRepo {
  final PlaceLocalDataSource _localDataSource;
  final PlaceRemoteDataSource _remoteDataSource;
  final FoodLocalDataSource _foodLocalDataSource;
  final FoodRemoteDataSource _foodRemoteDataSource;

  PlaceRepoImpl(
    this._localDataSource,
    this._remoteDataSource,
    this._foodLocalDataSource,
    this._foodRemoteDataSource,
  );

  StreamSubscription<List<Place>>? _placesRemoteStreamSub;

  @override
  initialize() {
    _placesRemoteStreamSub = _remoteDataSource.observePlaces().listen((places) {
      _localDataSource.savePlaces(places);
    });
  }

  @override
  Stream<List<Place>> observePlaces() {
    return _localDataSource.observePlaces();
  }

  @override
  Future<void> addPlace(Place place) {
    return _remoteDataSource.addPlace(place);
  }

  @override
  Future<List<Place>> getPlaces() {
    return Future.value(_localDataSource.getPlaces());
  }

  @override
  Future<Place> getPlace(String id) {
    return Future.value(_localDataSource.getPlace(id));
  }

  @override
  dispose() {
    _placesRemoteStreamSub?.cancel();
    _placesRemoteStreamSub = null;
  }

  @override
  deletePlace(String id) async {
    final Place? place = _localDataSource.getPlace(id);
    if (place != null) {
      for (var foodId in place.foods.keys) {
        _foodRemoteDataSource.deletePlaceInFood(foodId: foodId, placeId: id);
        _foodLocalDataSource.deletePlaceInFood(foodId: foodId, placeId: id);
      }
      await _remoteDataSource.deletePlace(id);
    }
  }

  @override
  Stream<Place?> observeOnePlace(String input) {
    return observePlaces().map((event) {
      final foods = _foodLocalDataSource.getFoods();
      final item = event.firstWhereOrNull((element) => element.id == input);
      return item?.withFoods(foods);
    });
  }

  @override
  Future<void> addReview(Review review) {
    return _remoteDataSource.addReview(review);
  }

  @override
  Future<bool> addFoodInPlace({
    required String foodId,
    required String placeId,
  }) {
    return _remoteDataSource.addFoodInPlace(foodId: foodId, placeId: placeId);
  }

  @override
  Future<bool> removeFoodInPlace({
    required String foodId,
    required String placeId,
  }) {
    return _remoteDataSource.removeFoodInPlace(
      foodId: foodId,
      placeId: placeId,
    );
  }

  @override
  Future<List<Place>> searchPlace(String keyword) {
    final places = _localDataSource.getPlaces();
    return Future.value(places
        .where((element) =>
            element.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList());
  }

  @override
  Future<bool> deleteFoodInPlace(
      {required String placeId, required String foodId}) {
    return _remoteDataSource.deleteFoodInPlace(
        foodId: foodId, placeId: placeId);
  }
}
