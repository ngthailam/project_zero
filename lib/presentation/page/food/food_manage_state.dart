import 'package:de1_mobile_friends/domain/model/food.dart';

abstract class FoodManageState {
  final List<Food>? foods;

  FoodManageState({this.foods});
}

class FoodManageInitialState extends FoodManageState {}

class FoodManagePrimaryState extends FoodManageState {
  FoodManagePrimaryState(List<Food> foodList) : super(foods: foodList);
}

class FoodManageErrorState extends FoodManageState {
  final Exception e;

  FoodManageErrorState(this.e);
}
