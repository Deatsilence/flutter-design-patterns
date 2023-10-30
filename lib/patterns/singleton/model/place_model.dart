import 'package:design_patterns/patterns/singleton/model/base_model.dart';
import 'package:flutter/material.dart';

@immutable
final class Place extends BaseModel {
  final String? name;
  final double? latitude;
  final double? longitude;

  Place({
    this.name,
    this.latitude,
    this.longitude,
  });
  Map<String, dynamic> _toMap() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  fromJson(Map<String, dynamic> json) => Place(
        name: json['name'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );

  @override
  Map<String, dynamic> toJson() => _toMap();
}
