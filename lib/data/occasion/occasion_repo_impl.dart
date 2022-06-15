import 'package:de1_mobile_friends/data/occasion/occasion_local_datasource.dart';
import 'package:de1_mobile_friends/data/occasion/occasion_remote_datasource.dart';
import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:de1_mobile_friends/domain/repo/occasion_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OccasionRepo)
class OccasionRepoImpl extends OccasionRepo {
  final OccasionRemoteDataSource _occasionRemoteDataSource;
  final OccasionLocalDataSource _occasionLocalDataSource;

  OccasionRepoImpl(
    this._occasionRemoteDataSource,
    this._occasionLocalDataSource,
  );

  @override
  Future<Occasion> getOccasions() async {
    final occasionLocal = _occasionLocalDataSource.getOccasion();
    if (occasionLocal != null) {
      return occasionLocal;
    }

    final occasionRemote = await _occasionRemoteDataSource.getOccasion();
    _occasionLocalDataSource.saveOccasion(occasionRemote);

    return occasionRemote;
  }
}
