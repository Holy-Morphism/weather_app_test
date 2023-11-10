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
