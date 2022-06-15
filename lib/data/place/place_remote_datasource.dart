import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/domain/model/review.dart';
import 'package:de1_mobile_friends/uuid_generator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

abstract class PlaceRemoteDataSource {
  Stream<List<Place>> observePlaces();

  Future<void> addPlace(Place place);

  Future<bool> deletePlace(String id);

  Future<void> addReview(Review review);
}

@Injectable(as: PlaceRemoteDataSource)
class PlaceRemoteDataSourceImpl extends PlaceRemoteDataSource {
  static const String firebaseRef = 'place';

  @override
  Stream<List<Place>> observePlaces() {
    final ref = FirebaseDatabase.instance.ref(firebaseRef);
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
    DatabaseReference ref = firebase.ref("$firebaseRef/${savedPlace.id}");
    await ref.set(savedPlace.toJson());
    return;
  }

  @override
  Future<bool> deletePlace(String id) async {
    FirebaseDatabase firebase = FirebaseDatabase.instance;
    DatabaseReference ref = firebase.ref("$firebaseRef/$id");
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
    DatabaseReference ref =
        firebase.ref("$firebaseRef/${_review.placeId}/reviews/${_review.id}");
    await ref.set(_review.toJson());
    return;
  }
}
