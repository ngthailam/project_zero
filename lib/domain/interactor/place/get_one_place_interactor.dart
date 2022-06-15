import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/domain/repo/place_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOnePlaceInteractor extends BaseInteractor<String, Place?> {
  final PlaceRepo _placeRepo;

  GetOnePlaceInteractor(this._placeRepo);

  @override
  Future<Place?> execute(String input) {
    return _placeRepo.getPlace(input);
  }
}
