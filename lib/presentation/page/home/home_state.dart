import 'package:de1_mobile_friends/domain/model/food.dart';

abstract class HomeState {
  final List<Food>? foods;
  final Food? pickedFood;

  HomeState({
    this.foods,
    this.pickedFood,
  });
}

class HomeLoadingState extends HomeState {}

class HomePrimaryState extends HomeState {
  HomePrimaryState({
    List<Food>? foods,
    Food? pickedFood,
  }) : super(foods: foods, pickedFood: pickedFood);
}

