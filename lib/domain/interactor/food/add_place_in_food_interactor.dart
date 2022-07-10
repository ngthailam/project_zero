import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddPlaceInFoodInteractor extends BaseInteractor<AddPlaceInFoodInput, void> {
  final FoodRepo _foodRepo;

  AddPlaceInFoodInteractor(this._foodRepo);

  @override
  Future<void> execute(AddPlaceInFoodInput input) {
    return _foodRepo.addPlaceInFood(foodId: input.foodId, placeId: input.placeId);
  }
}

class AddPlaceInFoodInput {
  final String foodId;
  final String placeId;

  AddPlaceInFoodInput({required this.foodId, required this.placeId});
}
