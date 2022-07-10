import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetFoodCategoriesInteractor
    extends BaseInteractor<void, Map<String, String>> {
  final FoodRepo _foodRepo;

  GetFoodCategoriesInteractor(this._foodRepo);

  @override
  Future<Map<String, String>> execute(void input) {
    return _foodRepo.getCategories();
  }
}
