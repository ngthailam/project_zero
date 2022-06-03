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

  factory FoodType.fromJson(Map<String, dynamic> json) =>
      _$FoodTypeFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FoodTypeToJson(this);
}
