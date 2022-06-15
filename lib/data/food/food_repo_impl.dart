import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/food_type.dart';
import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:de1_mobile_friends/domain/repo/occasion_repo.dart';
import 'package:de1_mobile_friends/uuid_generator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FoodRepo)
class FoodRepoImpl extends FoodRepo {
  final OccasionRepo _occasionRepo;

  FoodRepoImpl(this._occasionRepo);

  @override
  Future<List<Food>> getAllFoods() async {
    try {
      final ref = FirebaseDatabase.instance.ref("food");

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
    final ref = FirebaseDatabase.instance.ref('food');
    return ref.onValue.map((DatabaseEvent event) {
      return event.snapshot.children
          .map((e) => Food.fromJson(e.value as Map<String, dynamic>))
          .toList();
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
    DatabaseReference ref = firebase.ref("food/${food.id}");
    await ref.set(food.toJson());
    return true;
  }

  @override
  Future<bool> deleteFood(String id) async {
    FirebaseDatabase firebase = FirebaseDatabase.instance;
    DatabaseReference ref = firebase.ref("food/$id");
    await ref.remove();
    return true;
  }
}
