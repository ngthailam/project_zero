import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/food_type.dart';

abstract class FoodRepo {
  Future<List<Food>> getAllFoods();

  Future<bool> addFood(String foodName, {FoodType? type});

  Stream<List<Food>> observeAllFoods();

  Future<bool> deleteFood(String id);
}
