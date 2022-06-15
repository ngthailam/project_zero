import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:injectable/injectable.dart';

Occasion? _occasion;

abstract class OccasionLocalDataSource {
  Occasion? getOccasion();

  void saveOccasion(Occasion occasion);
}

@Injectable(as: OccasionLocalDataSource)
class OccasionLocalDataSourceImpl extends OccasionLocalDataSource {
  static const String firebaseRef = 'occasion';

  @override
  Occasion? getOccasion() {
    return _occasion;
  }

  @override
  void saveOccasion(Occasion occasion) {
    _occasion = occasion;
  }
}
