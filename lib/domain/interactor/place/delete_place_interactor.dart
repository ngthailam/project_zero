import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/either.dart';
import 'package:de1_mobile_friends/domain/repo/place_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeletePlaceInteractor
    extends BaseInteractor<String, Either<bool, Exception>> {
  final PlaceRepo _placeRepo;

  DeletePlaceInteractor(this._placeRepo);

  @override
  Future<Either<bool, Exception>> execute(String input) async {
    try {
      final result = await _placeRepo.deletePlace(input);
      return Either(data: result);
    } on Exception catch (e) {
      return Either(exception: e);
    }
  }
}
