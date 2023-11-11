import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_app_test/core/error/exception.dart';
import 'package:weather_app_test/core/error/failure.dart';
import 'package:weather_app_test/data/data_sources/remote_data_source.dart';
import 'package:weather_app_test/domain/entities/weather_entity.dart';
import 'package:weather_app_test/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(message: 'An error has occured'));
    } on SocketException {
      return const Left(
          ConnectionFailure(message: 'Failed to connect to network'));
    }
  }
}
