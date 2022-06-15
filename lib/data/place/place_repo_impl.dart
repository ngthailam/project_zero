import 'dart:async';

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

  PlaceRepoImpl(this._localDataSource, this._remoteDataSource);

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
  deletePlace(String id) {
    _remoteDataSource.deletePlace(id);
  }

  @override
  Stream<Place?> observeOnePlace(String input) {
    return observePlaces().map((event) {
      return event.firstWhereOrNull((element) => element.id == input);
    });
  }

  @override
  Future<void> addReview(Review review) {
    return _remoteDataSource.addReview(review);
  }
}
