// To parse this JSON data, do
//
//     final tempModel = tempModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TempModel tempModelFromJson(String str) => TempModel.fromJson(json.decode(str));

String tempModelToJson(TempModel data) => json.encode(data.toJson());

class TempModel {
  TempModel({
    required this.temp,
  });

  final double temp;

  factory TempModel.fromJson(Map<String, dynamic> json) => TempModel(
        temp: json["temp"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
      };
}
