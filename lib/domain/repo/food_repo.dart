import 'package:de1_mobile_friends/domain/model/food.dart';

abstract class FoodRepo {
  Future<List<Food>> getAllFoods();

  Future<bool> addFood(String foodName);

  Stream<List<Food>> observeAllFoods();

  Future<bool> deleteFood(String id);
}
