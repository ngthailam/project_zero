import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/domain/repo/place_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPlacesInteractor extends BaseInteractor<void, List<Place>> {
  final PlaceRepo _placeRepo;

  GetPlacesInteractor(this._placeRepo);

  @override
  Future<List<Place>> execute(void input) {
    return _placeRepo.getPlaces();
  }
}
