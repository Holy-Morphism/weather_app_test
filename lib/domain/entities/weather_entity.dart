// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final String description;
  final String main;
  final String iconCode;
  final double temperature;
  final int pressure;
  final int humidity;
  const WeatherEntity({
    required this.cityName,
    required this.description,
    required this.main,
    required this.iconCode,
    required this.temperature,
    required this.pressure,
    required this.humidity,
  });

  WeatherEntity copyWith({
    String? cityName,
    String? description,
    String? main,
    String? iconCode,
    double? temperature,
    int? pressure,
    int? humidity,
  }) {
    return WeatherEntity(
      cityName: cityName ?? this.cityName,
      description: description ?? this.description,
      main: main ?? this.main,
      iconCode: iconCode ?? this.iconCode,
      temperature: temperature ?? this.temperature,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cityName': cityName,
      'description': description,
      'main': main,
      'iconCode': iconCode,
      'temperature': temperature,
      'pressure': pressure,
      'humidity': humidity,
    };
  }

  factory WeatherEntity.fromMap(Map<String, dynamic> map) {
    return WeatherEntity(
      cityName: map['cityName'] as String,
      description: map['description'] as String,
      main: map['main'] as String,
      iconCode: map['iconCode'] as String,
      temperature: map['temperature'] as double,
      pressure: map['pressure'] as int,
      humidity: map['humidity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherEntity.fromJson(String source) =>
      WeatherEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      cityName,
      description,
      main,
      iconCode,
      temperature,
      pressure,
      humidity,
    ];
  }
}
