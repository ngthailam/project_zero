import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/either.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddFoodInteractor extends BaseInteractor<Food, Either<bool, Exception>> {
  final FoodRepo _foodRepo;

  AddFoodInteractor(this._foodRepo);

  @override
  Future<Either<bool, Exception>> execute(Food input) {
    return _foodRepo.addFood(input);
  }
}
