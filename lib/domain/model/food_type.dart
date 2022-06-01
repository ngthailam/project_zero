import 'package:json_annotation/json_annotation.dart';

part 'food_type.g.dart';

@JsonSerializable()
class FoodType {
  final String id;
  final String name;

  FoodType({
    required this.id,
    required this.name,
  });

  factory FoodType.fromJson(Map<String, dynamic> json) => _$FoodTypeFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FoodTypeToJson(this);
}
