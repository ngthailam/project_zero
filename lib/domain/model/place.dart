import 'package:de1_mobile_friends/domain/model/review.dart';
import 'package:de1_mobile_friends/uuid_generator.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable(explicitToJson: true)
class Place extends Equatable {
  final String id;
  final String name;
  final String? direction;
  final Map<String, Review> reviews;
  // Key: food id
  // value: is enabled (always true currently)
  final Map<String, bool> foods;

  const Place({
    required this.id,
    required this.name,
    required this.direction,
    this.reviews = const {},
    this.foods = const {},
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

  Place copyWith({
    String? id,
    String? name,
    String? direction,
  }) =>
      Place(
        id: id ?? this.id,
        name: name ?? this.name,
        direction: direction ?? this.direction,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        direction,
        reviews,
        foods,
      ];
}
