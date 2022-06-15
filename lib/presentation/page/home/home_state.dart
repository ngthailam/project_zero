import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:de1_mobile_friends/tuAI/tu_ai.dart';

abstract class HomeState {
  final List<Food>? foods;
  final Food? pickedFood;
  final Food? foodResultTemp;
  final TuAiOutput? tuAiOutput;
  final Occasion? occasion;

  HomeState({
    this.foods,
    this.pickedFood,
    this.tuAiOutput,
    this.foodResultTemp,
    this.occasion,
  });
}

class HomeLoadingState extends HomeState {}

class HomePrimaryState extends HomeState {
  HomePrimaryState({
    List<Food>? foods,
    Food? pickedFood,
    TuAiOutput? tuAiOutput,
    Food? foodResultTemp,
    Occasion? occasion,
  }) : super(
            foods: foods,
            pickedFood: pickedFood,
            tuAiOutput: tuAiOutput,
            foodResultTemp: foodResultTemp,
            occasion: occasion);

  HomePrimaryState copyWith({
    List<Food>? foods,
    Food? pickedFood,
    TuAiOutput? tuAiOutput,
    Food? foodResultTemp,
    Occasion? occasion,
  }) =>
      HomePrimaryState(
        foods: foods ?? this.foods,
        pickedFood: pickedFood ?? this.pickedFood,
        tuAiOutput: tuAiOutput ?? this.tuAiOutput,
        foodResultTemp: foodResultTemp ?? this.foodResultTemp,
        occasion: occasion ?? this.occasion,
      );
}
