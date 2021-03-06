import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';

part 'food_manage_state.g.dart';

@CopyWith()
class FoodManageState {
  final List<Food>? foods;
  final Map<String, List<Food>> displayedFoods;
  final String searchKeyword;

  FoodManageState({
    this.displayedFoods = const {},
    this.foods,
    this.searchKeyword = '',
  });
}
