import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/domain/repo/place_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchPlaceInteractor extends BaseInteractor<String, List<Place>> {
  final PlaceRepo _placeRepo;

  SearchPlaceInteractor(this._placeRepo);

  @override
  Future<List<Place>> execute(String input) {
    if (input.isEmpty) return Future.value([]);
    return _placeRepo.searchPlace(input);
  }
}
