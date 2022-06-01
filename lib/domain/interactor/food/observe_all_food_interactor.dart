import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ObserveAllFoodInteractor
    extends BaseInteractor<void, Stream<List<Food>>> {
  final FoodRepo _foodRepo;

  ObserveAllFoodInteractor(this._foodRepo);

  @override
  Future<Stream<List<Food>>> execute(void input) async {
    return _foodRepo.observeAllFoods();
  }
}
