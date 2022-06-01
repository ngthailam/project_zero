import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllFoodInteractor extends BaseInteractor<void, List<Food>> {
  final FoodRepo _foodRepo;

  GetAllFoodInteractor(this._foodRepo);

  @override
  Future<List<Food>> execute(void input) {
    return _foodRepo.getAllFoods();
  }
}
