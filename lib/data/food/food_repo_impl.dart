import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/food_type.dart';
import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:de1_mobile_friends/domain/repo/occasion_repo.dart';
import 'package:de1_mobile_friends/uuid_generator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

class FoodFirebaseKey {
  static const String main = 'food';
  static const String places = 'places';
}

@Singleton(as: FoodRepo)
class FoodRepoImpl extends FoodRepo {
  final OccasionRepo _occasionRepo;

  FoodRepoImpl(this._occasionRepo);

  // Need to clean this up later
  List<Food> _foods = [];

  @override
  Future<List<Food>> getAllFoods() async {
    try {
      final ref = FirebaseDatabase.instance.ref(FoodFirebaseKey.main);

      final snapshot = await ref.get();
      return snapshot.children
          .map((e) => Food.fromJson(e.value as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Stream<List<Food>> observeAllFoods() {
    final ref = FirebaseDatabase.instance.ref(FoodFirebaseKey.main);
    return ref.onValue.map((DatabaseEvent event) {
      final foods = event.snapshot.children
          .map((e) => Food.fromJson(e.value as Map<String, dynamic>))
          .toList();
      _foods = foods;
      return foods;
    });
  }

  @override
  Future<bool> addFood(
    String foodName, {
    FoodType? type,
    Occasion? occasion,
  }) async {
    Occasion foodOccasion = occasion ?? await _occasionRepo.getOccasions();
    final food = Food(
      id: generateRandomUuid(),
      name: foodName,
      type: type ?? FoodType(),
      occasion: foodOccasion.occasions,
    );
    FirebaseDatabase firebase = FirebaseDatabase.instance;
    DatabaseReference ref = firebase.ref("${FoodFirebaseKey.main}/${food.id}");
    await ref.set(food.toJson());
    return true;
  }

  @override
  Future<bool> deleteFood(String id) async {
    FirebaseDatabase firebase = FirebaseDatabase.instance;
    DatabaseReference ref = firebase.ref("${FoodFirebaseKey.main}/$id");
    await ref.remove();
    return true;
  }

  @override
  Future<bool> addPlaceInFood(
      {required String foodId, required String placeId}) async {
    try {
      FirebaseDatabase firebase = FirebaseDatabase.instance;
      final refPath =
          "${FoodFirebaseKey.main}/$foodId/${FoodFirebaseKey.places}";
      DatabaseReference ref = firebase.ref(refPath);
      ref.update({placeId: true});
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deletePlaceInFood(
      {required String foodId, required String placeId}) async {
    try {
      FirebaseDatabase firebase = FirebaseDatabase.instance;
      final refPath =
          "${FoodFirebaseKey.main}/$foodId/${FoodFirebaseKey.places}/$placeId";
      DatabaseReference ref = firebase.ref(refPath);
      await ref.remove();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<List<Food>> searchByName({required String keyword}) async {
    return _foods
        .where((element) =>
            element.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }
}
