import 'package:de1_mobile_friends/domain/model/occasion.dart';
import 'package:de1_mobile_friends/domain/repo/food_repo.dart';
import 'package:de1_mobile_friends/domain/repo/occasion_repo.dart';
import 'package:de1_mobile_friends/main.dart';
import 'package:firebase_database/firebase_database.dart';

// Only use to pre occupy data in firebase once
Future fillFoodsWithOccasion() async {
  try {
    Occasion foodOccasion = await getIt<OccasionRepo>().getOccasions();

    final foodIds =
        (await getIt<FoodRepo>().getAllFoods()).map((e) => e.id).toList();

    final Map<String, Map> updates = {};

    for (var element in foodIds) {
      updates['food/$element/occasion'] = foodOccasion.occasions;
    }

    final res = FirebaseDatabase.instance.ref().update(updates);
    return res;
  } catch (e) {
    // Do nothing for now
  }
}
