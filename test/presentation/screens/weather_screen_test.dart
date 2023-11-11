import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_test/domain/entities/weather_entity.dart';
import 'package:weather_app_test/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_test/presentation/bloc/weather_event.dart';
import 'package:weather_app_test/presentation/bloc/weather_state.dart';
import 'package:weather_app_test/presentation/screens/weather_screen.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global = null;
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

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group(
    'widget Testing',
    () {
      testWidgets(
          'Text field should trigger state to change from empty to loading',
          (widgetTester) async {
        //arrange
        when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());

        //act
        await widgetTester
            .pumpWidget(makeTestableWidget(const WeatherScreen()));
        var textfield = find.byType(TextField);
        expect(textfield, findsOneWidget);
        await widgetTester.enterText(textfield, 'New York');
        await widgetTester.pump();
        expect(find.text('New York'), findsOneWidget);
      });

      testWidgets('Show progress indicater when state is loading',
          (widgetTester) async {
        //arrange
        when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

        //act
        await widgetTester
            .pumpWidget(makeTestableWidget(const WeatherScreen()));

        //assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets(
          'Should show widget containing weather data when state is weather loaded',
          (widgetTester) async {
        //arrange
        when(() => mockWeatherBloc.state)
            .thenReturn(const WeatherLoaded(testWeatherdetail));

        //act
        await widgetTester
            .pumpWidget(makeTestableWidget(const WeatherScreen()));
        await widgetTester.pumpAndSettle(
            const Duration(milliseconds: 500)); //My own intervention
        //https://stackoverflow.com/questions/42448410/how-can-i-run-a-unit-test-when-the-tapped-widget-launches-a-timer

        //assert
        expect(find.byKey(const Key('weather_data')), findsOneWidget);
      });
    },
  );
}
