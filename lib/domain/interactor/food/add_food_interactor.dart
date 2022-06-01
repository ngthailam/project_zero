import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/either.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddFoodInteractor
    extends BaseInteractor<String, Either<bool, Exception>> {
  final FoodRepo _foodRepo;

  AddFoodInteractor(this._foodRepo);

  @override
  Future<Either<bool, Exception>> execute(String input) async {
    try {
      final result = await _foodRepo.addFood(input);
      return Either(data: result);
    } on Exception catch (e) {
      return Either(exception: e);
    }
  }
}
