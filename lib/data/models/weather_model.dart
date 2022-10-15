// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class WeatherModel {
  Map<String?, dynamic>? location;
  Map<String?, dynamic>? current;

  WeatherModel({
    this.location,
    this.current,
  });

  WeatherModel copyWith({
    Map<String, dynamic>? location,
    Map<String, dynamic>? current,
  }) {
    return WeatherModel(
      location: location ?? this.location,
      current: current ?? this.current,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location,
      'current': current,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return map['location'] == null
        ? WeatherModel()
        : WeatherModel(
            location: Map<String, dynamic>.from(
                (map['location'] as Map<String, dynamic>)),
            current: Map<String, dynamic>.from(
                (map['current'] as Map<String, dynamic>)));
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WeatherModel(location: $location, current: $current)';

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return mapEquals(other.location, location) &&
        mapEquals(other.current, current);
  }

  @override
  int get hashCode => location.hashCode ^ current.hashCode;
}
