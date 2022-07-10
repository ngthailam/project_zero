import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/occasion.dart';

part 'food_manage_state.g.dart';

@CopyWith()
class FoodManageState {
  final Map<String, List<Food>> foodInCategories;
  final Occasion? occasion;

  FoodManageState({
    this.foodInCategories = const {},
    this.occasion,
  });
}
