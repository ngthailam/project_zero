import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/domain/model/review.dart';
import 'package:de1_mobile_friends/uuid_generator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

class PlaceFirebaseKey {
  static const String main = 'place';
  static const String reviews = 'reviews';
  static const String foods = 'foods';
}

abstract class PlaceRemoteDataSource {
  Stream<List<Place>> observePlaces();

  Future<void> addPlace(Place place);

  Future<bool> deletePlace(String id);

  Future<void> addReview(Review review);

  Future<bool> addFoodInPlace({
    required String foodId,
    required String placeId,
  });

  Future<bool> removeFoodInPlace({
    required String foodId,
    required String placeId,
  });

  Future<bool> deleteFoodInPlace(
      {required String foodId, required String placeId});
}

@Injectable(as: PlaceRemoteDataSource)
class PlaceRemoteDataSourceImpl extends PlaceRemoteDataSource {
  @override
  Stream<List<Place>> observePlaces() {
    final ref = FirebaseDatabase.instance.ref(PlaceFirebaseKey.main);
    return ref.onValue.map((DatabaseEvent event) {
      return event.snapshot.children.map((e) {
        final json = e.value as Map<String, dynamic>;
        return Place.fromJson(json);
      }).toList();
    });
  }

  @override
  Future<void> addPlace(Place place) async {
    final savedPlace = place.copyWith(id: generateRandomUuid());
    FirebaseDatabase firebase = FirebaseDatabase.instance;
    DatabaseReference ref =
        firebase.ref("${PlaceFirebaseKey.main}/${savedPlace.id}");
    await ref.set(savedPlace.toJson());
    return;
  }

  @override
  Future<bool> deletePlace(String id) async {
    FirebaseDatabase firebase = FirebaseDatabase.instance;
    DatabaseReference ref = firebase.ref("${PlaceFirebaseKey.main}/$id");
    await ref.remove();
    return true;
  }

  @override
  Future<void> addReview(Review review) async {
    Review _review = review;
    if (review.id.isEmpty) {
      _review = review.copyWith(id: generateRandomUuid());
    }
    _review = _review.copyWith(
        createTimeMillisSinceEpoch: DateTime.now().millisecondsSinceEpoch);
    FirebaseDatabase firebase = FirebaseDatabase.instance;
    DatabaseReference ref = firebase.ref(
        "${PlaceFirebaseKey.main}/${_review.placeId}/${PlaceFirebaseKey.reviews}/${_review.id}");
    await ref.set(_review.toJson());
    return;
  }

  @override
  Future<bool> addFoodInPlace(
      {required String foodId, required String placeId}) async {
    try {
      FirebaseDatabase firebase = FirebaseDatabase.instance;
      final refPath =
          "${PlaceFirebaseKey.main}/$placeId/${PlaceFirebaseKey.foods}";
      DatabaseReference ref = firebase.ref(refPath);
      ref.update({foodId: true});
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deleteFoodInPlace(
      {required String foodId, required String placeId}) async {
    try {
      FirebaseDatabase firebase = FirebaseDatabase.instance;
      final refPath =
          "${PlaceFirebaseKey.main}/$placeId/${PlaceFirebaseKey.foods}/$foodId";
      DatabaseReference ref = firebase.ref(refPath);
      await ref.remove();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<bool> removeFoodInPlace(
      {required String foodId, required String placeId}) async {
    try {
      FirebaseDatabase firebase = FirebaseDatabase.instance;
      final refPath =
          "${PlaceFirebaseKey.main}/$placeId/${PlaceFirebaseKey.foods}/$foodId";
      DatabaseReference ref = firebase.ref(refPath);
      await ref.remove();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
