import 'package:de1_mobile_friends/domain/interactor/base_interactor.dart';
import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:de1_mobile_friends/domain/repo/occasion_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOccasionInteractor extends BaseInteractor<void, Occasion> {
  final OccasionRepo _occasionRepo;

  GetOccasionInteractor(this._occasionRepo);

  @override
  Future<Occasion> execute(void input) {
    return _occasionRepo.getOccasions();
  }
}
