// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['id'] as String? ?? '',
      placeId: json['placeId'] as String,
      text: json['text'] as String,
      rating: json['rating'] as int?,
      price: $enumDecodeNullable(_$RvPriceEnumMap, json['price']),
      distance: $enumDecodeNullable(_$RvDistanceEnumMap, json['distance']),
      waitTime: $enumDecodeNullable(_$RvWaitTimeEnumMap, json['waitTime']),
      createTimeMillisSinceEpoch:
          json['createTimeMillisSinceEpoch'] as int? ?? 0,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'placeId': instance.placeId,
      'text': instance.text,
      'rating': instance.rating,
      'price': _$RvPriceEnumMap[instance.price],
      'distance': _$RvDistanceEnumMap[instance.distance],
      'waitTime': _$RvWaitTimeEnumMap[instance.waitTime],
      'createTimeMillisSinceEpoch': instance.createTimeMillisSinceEpoch,
    };

const _$RvPriceEnumMap = {
  RvPrice.cheap: 'cheap',
  RvPrice.quiteCheap: 'quiteCheap',
  RvPrice.normal: 'normal',
  RvPrice.aLittleExpensive: 'aLittleExpensive',
  RvPrice.expensive: 'expensive',
};

const _$RvDistanceEnumMap = {
  RvDistance.near: 'near',
  RvDistance.average: 'average',
  RvDistance.far: 'far',
};

const _$RvWaitTimeEnumMap = {
  RvWaitTime.short: 'short',
  RvWaitTime.normal: 'normal',
  RvWaitTime.long: 'long',
};
