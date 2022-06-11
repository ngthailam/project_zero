import 'package:de1_mobile_friends/domain/model/food.dart';

abstract class PlaceAddState {}

class PlaceAddPrimaryState extends PlaceAddState {
  final List<Food>? foods;

  PlaceAddPrimaryState({this.foods});
}

class PlaceAddErrorState extends PlaceAddState {
  final Exception e;

  PlaceAddErrorState(this.e);
}

class PlaceAddSuccessState extends PlaceAddState {}
