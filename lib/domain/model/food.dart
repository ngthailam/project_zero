import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:de1_mobile_friends/domain/model/place.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

part 'food.g.dart';

@CopyWith()
@JsonSerializable(explicitToJson: true)
class Food extends Equatable {
  final String id;
  final String name;
  final Map<String, dynamic>? occasion;
  // key: Place id
  // value: is enabled
  // This is the value stored in database
  final Map<String, bool> places;
  // Not stored in database, this value is get
  // through placeIds
  final List<Place> placeList;
  final Map<String, bool>? categories;

  const Food({
    required this.id,
    required this.name,
    this.occasion,
    this.places = const {},
    this.categories = const {},
    this.placeList = const [],
  });

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FoodToJson(this);

  Food withPlaces(List<Place> places) {
    final List<Place> placesWithFood = [];

    this.places.forEach((key, value) {
      if (value == true) {
        final matchedPlace =
            places.firstWhereOrNull((element) => element.id == key);
        if (matchedPlace != null) {
          placesWithFood.add(matchedPlace);
        }
      }
    });

    return copyWith(placeList: placesWithFood);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        occasion,
        places,
        placeList,
        categories,
      ];
}
