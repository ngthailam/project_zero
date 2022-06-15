import 'package:de1_mobile_friends/domain/model/occasion.dart';

abstract class OccasionRepo {
  Future<Occasion> getOccasions();
}
