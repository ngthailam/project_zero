import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable(explicitToJson: true)
class Place extends Equatable {
  final String id;
  final String name;
  final String? direction;

  const Place({
    required this.id,
    required this.name,
    required this.direction,
  });

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
  List<Object?> get props => [id, name, direction];
}
