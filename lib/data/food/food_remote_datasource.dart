import 'package:de1_mobile_friends/data/food/food_repo_impl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

abstract class FoodRemoteDataSource {
   Future<bool> deletePlaceInFood({required String foodId, required String placeId});
}

@Injectable(as: FoodRemoteDataSource)
class FoodRemoteDataSourceImpl extends FoodRemoteDataSource {
  @override
  Future<bool> deletePlaceInFood({required String foodId, required String placeId}) async {
    try {
      FirebaseDatabase firebase = FirebaseDatabase.instance;
      final refPath =
          "${FoodFirebaseKey.main}/$foodId/${FoodFirebaseKey.places}/$placeId";
      DatabaseReference ref = firebase.ref(refPath);
      await ref.remove();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
