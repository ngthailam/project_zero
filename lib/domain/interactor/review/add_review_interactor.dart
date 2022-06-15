import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/review.dart';
import 'package:de1_mobile_friends/domain/repo/place_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddReviewInteractor extends BaseInteractor<Review, void> {
  final PlaceRepo _placeRepo;

  AddReviewInteractor(this._placeRepo);

  @override
  Future<void> execute(Review input) {
    return _placeRepo.addReview(input);
  }
}
