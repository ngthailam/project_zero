import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/occasion.dart';

abstract class FoodManageState {
  final List<Food>? foods;
  final Occasion? occasion;

  FoodManageState({this.foods, this.occasion});
}

class FoodManageInitialState extends FoodManageState {}

class FoodManagePrimaryState extends FoodManageState {
  FoodManagePrimaryState({List<Food>? foods, Occasion? occasion})
      : super(
          foods: foods,
          occasion: occasion,
        );
}

class FoodManageErrorState extends FoodManageState {
  final Exception e;

  FoodManageErrorState(this.e);
}
