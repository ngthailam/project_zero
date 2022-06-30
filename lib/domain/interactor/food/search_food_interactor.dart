import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchFoodInteractor extends BaseInteractor<String, List<Food>> {
  final FoodRepo _foodRepo;

  SearchFoodInteractor(this._foodRepo);

  @override
  Future<List<Food>> execute(String input) {
    if (input.isEmpty) return Future.value([]);
    return _foodRepo.searchByName(keyword: input);
  }
}
