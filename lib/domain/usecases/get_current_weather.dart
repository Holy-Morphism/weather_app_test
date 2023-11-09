import 'package:dartz/dartz.dart';
import 'package:weather_app_test/core/error/failure.dart';
import 'package:weather_app_test/domain/entities/weather_entity.dart';
import 'package:weather_app_test/domain/repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository _weatherRepository;
  GetCurrentWeather(this._weatherRepository);
  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return _weatherRepository.getCurrentWeather(cityName);
  }
}
