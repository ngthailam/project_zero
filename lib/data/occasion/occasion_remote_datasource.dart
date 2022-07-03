import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

abstract class OccasionRemoteDataSource {
  Future<Occasion> getOccasion();
}

@Injectable(as: OccasionRemoteDataSource)
class OccasionRemoteDataSourceImpl extends OccasionRemoteDataSource {
  static const String firebaseRef = 'occasion';

  @override
  Future<Occasion> getOccasion() async {
    try {
      final ref = FirebaseDatabase.instance.ref(firebaseRef);

      final snapshot = await ref.get();
      final snapshotMap = snapshot.value as Map<String, dynamic>;
      final occasions =
          snapshotMap.map(((key, value) => MapEntry(key, value as String)));

      return Occasion(occasions: occasions);
    } catch (e) {
      return Occasion();
    }
  }
}
