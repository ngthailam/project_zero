import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/occasion.dart';

abstract class FoodRepo {
  Future<List<Food>> getAllFoods();

  Future<bool> saveFood(
    String foodName, {
    String? id,
    Occasion? occasion,
    required Map<String, bool> categories,
  });

  Stream<List<Food>> observeAllFoods();

  Future<bool> deleteFood(String id);

  Future<bool> addPlaceInFood({
    required String foodId,
    required String placeId,
  });

  Future<bool> deletePlaceInFood({
    required String foodId,
    required String placeId,
  });

  Future<List<Food>> searchByName({required String keyword});

  Future<Map<String, String>> getCategories();

  List<Food> getFoodsLocal();
}
