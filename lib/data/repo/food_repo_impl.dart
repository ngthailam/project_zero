import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:de1_mobile_friends/uuid_generator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FoodRepo)
class FoodRepoImpl extends FoodRepo {
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
  Future<bool> addFood(String foodName) async {
    final food = Food(id: generateRandomUuid(), name: foodName);
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
