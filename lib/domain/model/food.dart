import 'package:de1_mobile_friends/domain/model/food_type.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';

@JsonSerializable(explicitToJson: true)
class Food extends Equatable {
  final String id;
  final String name;
  final FoodType? type;
  final Map<String, dynamic>? occasion;
  // key: Place id
  // value: is enabled
  final Map<String, bool> places;

  const Food({
    required this.id,
    required this.name,
    this.occasion,
    this.type,
    this.places = const {},
  });

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FoodToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        occasion,
        places,
      ];
}
