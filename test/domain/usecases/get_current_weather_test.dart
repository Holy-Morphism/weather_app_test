import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_test/domain/entities/weather_entity.dart';
import 'package:weather_app_test/domain/usecases/get_current_weather.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetCurrentWeather getCurrentWeather;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeather = GetCurrentWeather(mockWeatherRepository);
  });

  const testWeatherdetail = WeatherEntity(
    cityName: 'New York',
    description: 'few clouds',
    main: 'Clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const String testCityName = 'New York';
  test('should get current weather detail from the repository', () async {
    // arrange
    when(mockWeatherRepository.getCurrentWeather(testCityName) as Function())
        .thenAnswer((_) async => const Right(testWeatherdetail));

    // act
    final result = getCurrentWeather.execute(testCityName);

    // assert
    expect(result, const Right(testWeatherdetail));
  });
}
