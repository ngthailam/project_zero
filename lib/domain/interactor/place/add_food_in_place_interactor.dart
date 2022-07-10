import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/repo/place_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddFoodInPlaceInteractor
    extends BaseInteractor<AddFoodInPlaceInput, void> {
  final PlaceRepo _placeRepo;

  AddFoodInPlaceInteractor(this._placeRepo);

  @override
  Future<void> execute(AddFoodInPlaceInput input) {
    return _placeRepo.addFoodInPlace(
      foodId: input.foodId,
      placeId: input.placeId,
    );
  }
}

class AddFoodInPlaceInput {
  final String foodId;
  final String placeId;

  AddFoodInPlaceInput({required this.foodId, required this.placeId});
}
