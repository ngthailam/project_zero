import 'package:de1_mobile_friends/domain/repo/place_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class PlaceFoodsInteractor {
  final PlaceRepo _placeRepo;

  PlaceFoodsInteractor(this._placeRepo);

  Future<bool> addFoodInPlace(
      {required String placeId, required String foodId}) {
    return _placeRepo.addFoodInPlace(foodId: foodId, placeId: placeId);
  }

  Future<bool> removeFoodInPlace(
      {required String placeId, required String foodId}) {
    return _placeRepo.removeFoodInPlace(foodId: foodId, placeId: placeId);
  }
}
