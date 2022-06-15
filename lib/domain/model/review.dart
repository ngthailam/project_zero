import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  final String id;
  final String placeId;
  final String text;
  final int? rating;
  final RvPrice? price;
  final RvDistance? distance;
  final RvWaitTime? waitTime;
  final int createTimeMillisSinceEpoch;

  Review({
    this.id = '',
    required this.placeId,
    required this.text,
    this.rating,
    this.price,
    this.distance,
    this.waitTime,
    this.createTimeMillisSinceEpoch = 0,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  Review copyWith({
    String? id,
    String? placeId,
    String? text,
    int? rating,
    RvPrice? price,
    RvDistance? distance,
    RvWaitTime? waitTime,
    int? createTimeMillisSinceEpoch,
  }) =>
      Review(
        id: id ?? this.id,
        placeId: placeId ?? this.placeId,
        text: text ?? this.text,
        rating: rating ?? this.rating,
        price: price ?? this.price,
        distance: distance ?? this.distance,
        waitTime: waitTime ?? this.waitTime,
        createTimeMillisSinceEpoch:
            createTimeMillisSinceEpoch ?? this.createTimeMillisSinceEpoch,
      );
}

enum RvPrice { cheap, quiteCheap, normal, aLittleExpensive, expensive }

enum RvDistance {
  near,
  average,
  far,
}

enum RvWaitTime {
  short,
  normal,
  long,
}
