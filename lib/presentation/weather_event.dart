import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class OncityChanged extends WeatherEvent {
  final String cityName;

  const OncityChanged(this.cityName);

  @override
  List<Object?> get props => [cityName];
}
