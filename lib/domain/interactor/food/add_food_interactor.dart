import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/either.dart';
import 'package:de1_mobile_friends/domain/model/food_type.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddFoodInteractor
    extends BaseInteractor<AddFoodInput, Either<bool, Exception>> {
  final FoodRepo _foodRepo;

  AddFoodInteractor(this._foodRepo);

  @override
  Future<Either<bool, Exception>> execute(AddFoodInput input) async {
    try {
      final result = await _foodRepo.addFood(input.name, type: input.type);
      return Either(data: result);
    } on Exception catch (e) {
      return Either(exception: e);
    }
  }
}

class AddFoodInput {
  final String name;
  final FoodType? type;

  AddFoodInput({required this.name, this.type});
}
