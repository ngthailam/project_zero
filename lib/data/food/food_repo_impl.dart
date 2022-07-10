import 'package:de1_mobile_friends/data/food/food_local_datasource.dart';
import 'package:de1_mobile_friends/data/food/food_remote_datasource.dart';
import 'package:de1_mobile_friends/data/place/place_local_datasource.dart';
import 'package:de1_mobile_friends/data/place/place_remote_datasource.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:de1_mobile_friends/domain/repo/occasion_repo.dart';
import 'package:de1_mobile_friends/uuid_generator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

class FoodFirebaseKey {
  static const String main = 'food';
  static const String places = 'places';
}

@Singleton(as: FoodRepo)
class FoodRepoImpl extends FoodRepo {
  final OccasionRepo _occasionRepo;
  final PlaceLocalDataSource _placeLocalDataSource;
  final FoodLocalDataSource _foodLocalDataSource;
  final PlaceRemoteDataSource _placeRemoteDataSource;
  final FoodRemoteDataSource _foodRemoteDataSource;

  FoodRepoImpl(
    this._occasionRepo,
    this._placeLocalDataSource,
    this._foodLocalDataSource,
    this._placeRemoteDataSource,
    this._foodRemoteDataSource,
  );

  @override
  List<Food> getFoodsLocal() {
    return _foodLocalDataSource.getFoods();
  }

  @override
  Future<List<Food>> getAllFoods() async {
    try {
      final ref = FirebaseDatabase.instance.ref(FoodFirebaseKey.main);
      final allPlaces = _placeLocalDataSource.getPlaces();

      final snapshot = await ref.get();
      return snapshot.children
          .map((e) => Food.fromJson(e.value as Map<String, dynamic>))
          .map((e) => e.withPlaces(allPlaces))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Stream<List<Food>> observeAllFoods() {
    final ref = FirebaseDatabase.instance.ref(FoodFirebaseKey.main);
    final allPlaces = _placeLocalDataSource.getPlaces();
    return ref.onValue.map((DatabaseEvent event) {
      final foods = event.snapshot.children
          .map((e) => Food.fromJson(e.value as Map<String, dynamic>))
          .map((e) => e.withPlaces(allPlaces))
          .toList();
      _foodLocalDataSource.saveFoods(foods);
      return foods;
    });
  }

  @override
  Future<bool> saveFood(
    String foodName, {
    Occasion? occasion,
    String? id,
    required Map<String, bool> categories,
  }) async {
    Occasion foodOccasion = occasion ?? await _occasionRepo.getOccasions();
    final food = Food(
      id: id ?? generateRandomUuid(),
      name: foodName,
      occasion: foodOccasion.occasions,
      categories: categories,
    );
    FirebaseDatabase firebase = FirebaseDatabase.instance;
    DatabaseReference ref = firebase.ref("${FoodFirebaseKey.main}/${food.id}");
    await ref.set(food.toJson());
    return true;
  }

  @override
  Future<bool> deleteFood(String id) async {
    final food = _foodLocalDataSource.getFood(id);
    FirebaseDatabase firebase = FirebaseDatabase.instance;
    DatabaseReference ref = firebase.ref("${FoodFirebaseKey.main}/$id");
    await ref.remove();
    // ignore: avoid_function_literals_in_foreach_calls
    food?.places.keys.forEach((placeId) {
      _placeRemoteDataSource.deleteFoodInPlace(placeId: placeId, foodId: id);
    });
    //
    return true;
  }

  @override
  Future<bool> addPlaceInFood(
      {required String foodId, required String placeId}) async {
    try {
      FirebaseDatabase firebase = FirebaseDatabase.instance;
      final refPath =
          "${FoodFirebaseKey.main}/$foodId/${FoodFirebaseKey.places}";
      DatabaseReference ref = firebase.ref(refPath);
      ref.update({placeId: true});
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deletePlaceInFood(
      {required String foodId, required String placeId}) async {
    final resultRemote = await _foodRemoteDataSource.deletePlaceInFood(
        foodId: foodId, placeId: placeId);
    final resulLocal = _foodLocalDataSource.deletePlaceInFood(
        foodId: foodId, placeId: placeId);
    return resultRemote && resulLocal;
  }

  @override
  Future<List<Food>> searchByName({required String keyword}) async {
    return _foodLocalDataSource
        .getFoods()
        .where((element) =>
            element.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  @override
  Future<Map<String, String>> getCategories() async {
    try {
      final ref = FirebaseDatabase.instance.ref('food_category');

      final snapshot = await ref.get();
      final snapshotMap = snapshot.value as Map<String, dynamic>;
      final categories =
          snapshotMap.map(((key, value) => MapEntry(key, value as String)));

      return categories;
    } catch (e) {
      return {};
    }
  }
}
