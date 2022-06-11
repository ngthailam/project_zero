import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/domain/repo/place_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddPlaceInteractor extends BaseInteractor<Place, void> {
  final PlaceRepo _placeRepo;

  AddPlaceInteractor(this._placeRepo);

  @override
  Future<void> execute(Place input) {
    return _placeRepo.addPlace(input);
  }
}
