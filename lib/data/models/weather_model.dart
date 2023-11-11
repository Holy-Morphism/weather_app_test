import 'package:weather_app_test/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel(
      {required super.cityName,
      required super.description,
      required super.main,
      required super.iconCode,
      required super.temperature,
      required super.pressure,
      required super.humidity});

  factory WeatherModel.fromJson(Map<String, dynamic> map) {
    return WeatherModel(
        cityName: map['name'],
        description: map['weather'][0]['description'],
        main: map['weather'][0]['main'],
        iconCode: map['weather'][0]['icon'],
        temperature: map['main']['temp'],
        pressure: map['main']['pressure'],
        humidity: map['main']['humidity']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'weather': [
        {
          'main': main,
          'description': description,
          'icon': iconCode,
        }
      ],
      'main': {
        'temp': temperature,
        'pressure': pressure,
        'humidity': humidity,
      },
    };
  }

  WeatherEntity toEntity() => WeatherEntity(
      cityName: cityName,
      description: description,
      main: main,
      iconCode: iconCode,
      temperature: temperature,
      pressure: pressure,
      humidity: humidity);
}
