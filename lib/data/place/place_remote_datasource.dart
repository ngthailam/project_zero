import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/uuid_generator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

abstract class PlaceRemoteDataSource {
  Stream<List<Place>> observePlaces();

  Future<void> addPlace(Place place);

  Future<bool> deletePlace(String id);
}

@Injectable(as: PlaceRemoteDataSource)
class PlaceRemoteDataSourceImpl extends PlaceRemoteDataSource {
  static const String firebaseRef = 'place';

  @override
  Stream<List<Place>> observePlaces() {
    final ref = FirebaseDatabase.instance.ref(firebaseRef);
    return ref.onValue.map((DatabaseEvent event) {
      return event.snapshot.children
          .map((e) => Place.fromJson(e.value as Map<String, dynamic>))
          .toList();
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
}
