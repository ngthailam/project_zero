import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/utils/load_state.dart';

part 'add_food_in_place_state.g.dart';

@CopyWith()
class AddFoodInPlaceState {
  final List<Food>? foods;
  final LoadState addFoodLoadState;

  AddFoodInPlaceState({
    this.foods,
    this.addFoodLoadState = LoadState.none,
  });
}
