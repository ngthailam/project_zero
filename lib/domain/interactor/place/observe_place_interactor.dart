import 'package:de1_mobile_friends/domain/interactor/non_future_base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:de1_mobile_friends/domain/repo/place_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ObservePlaceInteractor
    extends NonFutureBaseInteractor<void, Stream<List<Place>>> {
  final PlaceRepo _placeRepo;

  ObservePlaceInteractor(this._placeRepo);

  @override
  Stream<List<Place>> execute(void input) {
    return _placeRepo.observePlaces();
  }
}
