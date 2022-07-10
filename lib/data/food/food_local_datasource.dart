import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:injectable/injectable.dart';
import 'package:collection/collection.dart';

abstract class FoodLocalDataSource {
  List<Food> getFoods();

  saveFoods(List<Food> foods);

  Food? getFood(String id);

  bool deletePlaceInFood(
      {required String foodId, required String placeId});
}

@Singleton(as: FoodLocalDataSource)
class FoodLocalDataSourceImpl extends FoodLocalDataSource {
  List<Food> _foods = [];

  @override
  List<Food> getFoods() {
    return _foods;
  }

  @override
  Food? getFood(String id) {
    return _foods.firstWhereOrNull((element) => element.id == id);
  }

  @override
  saveFoods(List<Food> foods) {
    _foods = foods;
  }

  @override
  bool deletePlaceInFood(
      {required String foodId, required String placeId}) {
    final food = getFood(foodId);
    if (food != null) {
      food.places.remove(placeId);
    }

    return true;
  }
}
