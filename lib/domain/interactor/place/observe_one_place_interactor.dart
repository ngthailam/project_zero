import 'package:de1_mobile_friends/domain/interactor/non_future_base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/domain/repo/place_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ObserveOnePlaceInteractor
    extends NonFutureBaseInteractor<String, Stream<Place?>> {
  final PlaceRepo _placeRepo;

  ObserveOnePlaceInteractor(this._placeRepo);

  @override
  Stream<Place?> execute(String input) {
    return _placeRepo.observeOnePlace(input);
  }
}
