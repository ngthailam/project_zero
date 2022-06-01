import 'package:de1_mobile_friends/domain/model/food_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';

@JsonSerializable(explicitToJson: true)
class Food {
  final String id;
  final String name;
  final FoodType? type;

  Food({
    required this.id,
    required this.name,
    this.type,
  });

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FoodToJson(this);
}
