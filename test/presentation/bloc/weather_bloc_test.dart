import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_test/core/error/failure.dart';
import 'package:weather_app_test/domain/entities/weather_entity.dart';
import 'package:weather_app_test/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_test/presentation/bloc/weather_event.dart';
import 'package:weather_app_test/presentation/bloc/weather_state.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeather mockGetCurrentWeather;
  late WeatherBloc weatherBloc;
  setUp(() {
    mockGetCurrentWeather = MockGetCurrentWeather();
    weatherBloc = WeatherBloc(mockGetCurrentWeather);
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

  group('Weather Bloc test', () {
    test('Intial State should be empty', () {
      expect(weatherBloc.state, WeatherEmpty());
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading,WeatherLoaded] when get weather is successful.',
      build: () {
        when(mockGetCurrentWeather.execute(testCityName))
            .thenAnswer((_) async => const Right(testWeatherdetail));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OncityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => <WeatherState>[
        WeatherLoading(),
        const WeatherLoaded(testWeatherdetail)
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading,WeatherLoadFailure] when get weather is unsuccessful.',
      build: () {
        when(mockGetCurrentWeather.execute(testCityName)).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Server Failure')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OncityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => <WeatherState>[
        WeatherLoading(),
        const WeatherLoadFailure('Server Failure')
      ],
    );
  });
}
