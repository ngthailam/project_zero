import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/either.dart';
import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:de1_mobile_friends/utils/string_ext.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddFoodInteractor
    extends BaseInteractor<AddFoodInput, Either<bool, Exception>> {
  final FoodRepo _foodRepo;

  AddFoodInteractor(this._foodRepo);

  @override
  Future<Either<bool, Exception>> execute(AddFoodInput input) async {
    try {
      final result = await _foodRepo.saveFood(
        input.name.trim().capitalize(),
        id: input.id,
        occasion: input.occasion,
        categories: input.categories,
      );
      return Either(data: result);
    } on Exception catch (e) {
      return Either(exception: e);
    }
  }
}

class AddFoodInput {
  final String? id;
  final String name;
  final Occasion? occasion;
  final Map<String, bool> categories;

  AddFoodInput({
    this.id,
    required this.name,
    this.occasion,
    required this.categories,
  });
}
