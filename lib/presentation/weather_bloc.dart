import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app_test/domain/usecases/get_current_weather.dart';

import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather _getCurrentWeather;
  WeatherBloc(this._getCurrentWeather) : super(WeatherEmpty()) {
    on<OncityChanged>(
      (event, emit) async {
        emit(WeatherLoading());
        final result = await _getCurrentWeather.execute(event.cityName);
        result.fold(
          (failure) => emit(WeatherLoadFailure(failure.message)),
          (weather) => emit(
            WeatherLoaded(weather),
          ),
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return ((events, mapper) => events.debounceTime(duration).flatMap(mapper));
}
