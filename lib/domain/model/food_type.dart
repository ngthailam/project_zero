import 'package:json_annotation/json_annotation.dart';

part 'food_type.g.dart';

@JsonSerializable()
class FoodType {
  final bool cold;
  final bool hot;
  final bool water;

  FoodType({
    this.cold = false,
    this.hot = false,
    this.water = false,
  });

  factory FoodType.allTrue() => FoodType(hot: true, cold: true, water: true);

  FoodType copyWith({
    bool? cold,
    bool? hot,
    bool? water,
  }) =>
      FoodType(
        cold: cold ?? this.cold,
        hot: hot ?? this.hot,
        water: water ?? this.water,
      );

  factory FoodType.fromJson(Map<String, dynamic> json) =>
      _$FoodTypeFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FoodTypeToJson(this);
}
