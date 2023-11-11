import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_test/core/error/exception.dart';
import 'package:weather_app_test/core/error/failure.dart';
import 'package:weather_app_test/data/models/weather_model.dart';
import 'package:weather_app_test/data/repositories/weather_repository_impl.dart';
import 'package:weather_app_test/domain/entities/weather_entity.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    description: 'broken clouds',
    main: 'Clouds',
    iconCode: '04d',
    temperature: 283.03,
    pressure: 1019,
    humidity: 60,
  );

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    description: 'broken clouds',
    main: 'Clouds',
    iconCode: '04d',
    temperature: 283.03,
    pressure: 1019,
    humidity: 60,
  );

  const cityName = 'New York';

  group('Get current weather', () {
    test(
        'should return current weather when a call to data source is succesful',
        () async {
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(cityName))
          .thenAnswer((_) async => testWeatherModel);

      //act
      final result = await weatherRepositoryImpl.getCurrentWeather(cityName);

      //assert
      expect(result, equals(const Right(testWeatherEntity)));
    });

    test('should return server failure when call to data source is unsucceful',
        () async {
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(cityName))
          .thenThrow(ServerException());

      //act
      final result = await weatherRepositoryImpl.getCurrentWeather(cityName);

      //assert
      expect(result,
          equals(const Left(ServerFailure(message: 'An error has occured'))));
    });

    test(
        'should return connection failure when call to data source is unsuccessful',
        () async {
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(cityName))
          .thenThrow(const SocketException('Failed to connect to network'));

      //act
      final result = await weatherRepositoryImpl.getCurrentWeather(cityName);

      //assert
      expect(
          result,
          equals(const Left(
              ConnectionFailure(message: 'Failed to connect to network'))));
    });
  });
}
