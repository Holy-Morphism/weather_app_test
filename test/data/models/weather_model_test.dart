import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_test/data/models/weather_model.dart';
import 'package:weather_app_test/domain/entities/weather_entity.dart';

import '../../helper/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    description: 'broken clouds',
    main: 'Clouds',
    iconCode: '04d',
    temperature: 283.03,
    pressure: 1019,
    humidity: 60,
  );

  test('Should be a subclass odf weather entity', () {
    //arrange

    //act

    //assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('Should return a valid model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helper/dummy_data/dummy_weather_response.json'));

    //act
    final result = WeatherModel.fromJson(jsonMap);

    //assert

    expect(result, equals(testWeatherModel));
  });

  test('Should return a json map containing proper data ', () async {
    //arrange

    //act
    final result = testWeatherModel.toJson();

    //assert
    final expectedJsonValue = {
      'name': 'New York',
      'weather': [
        {
          'main': 'Clouds',
          'description': 'broken clouds',
          'icon': '04d',
        }
      ],
      'main': {
        'temp': 283.03,
        'pressure': 1019,
        'humidity': 60,
      },
    };

    expect(result, equals(expectedJsonValue));
  });
}
