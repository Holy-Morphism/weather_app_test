import 'package:dartz/dartz.dart';
import 'package:weather_app_test/core/error/failure.dart';
import 'package:weather_app_test/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
