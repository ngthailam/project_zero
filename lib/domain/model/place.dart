import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:de1_mobile_friends/domain/model/food.dart';
import 'package:de1_mobile_friends/domain/model/review.dart';
import 'package:de1_mobile_friends/uuid_generator.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

part 'place.g.dart';

@CopyWith()
@JsonSerializable(explicitToJson: true)
class Place extends Equatable {
  final String id;
  final String name;
  final String? direction;
  final Map<String, Review> reviews;
  // Key: food id
  // value: is enabled (always true currently)
  // values from database
  final Map<String, bool> foods;
  // real values
  final List<Food> foodList;

  const Place({
    required this.id,
    required this.name,
    required this.direction,
    this.reviews = const {},
    this.foods = const {},
    this.foodList = const [],
  });

  int get getAvgRating {
    int rating = -1;
    int count = 0;

    reviews.forEach((key, value) {
      if ((value.rating ?? 0) > 0) {
        count++;
        rating += value.rating!;
      }
    });

    if (count == 0) return rating;

    return rating ~/ count;
  }

  factory Place.empty() =>
      Place(id: generateRandomUuid(), name: '', direction: '');

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  Place withFoods(List<Food> foods) {
    final List<Food> foodsInPlace = [];

    this.foods.forEach((key, value) {
      if (value == true) {
        final matchedPlace =
            foods.firstWhereOrNull((element) => element.id == key);
        if (matchedPlace != null) {
          foodsInPlace.add(matchedPlace);
        }
      }
    });

    return copyWith(foodList: foodsInPlace);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        direction,
        reviews,
        foods,
        foodList,
      ];
}
