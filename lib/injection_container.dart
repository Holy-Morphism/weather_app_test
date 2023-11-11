import 'package:get_it/get_it.dart';
import 'package:weather_app_test/data/data_sources/remote_data_source.dart';
import 'package:weather_app_test/data/repositories/weather_repository_impl.dart';
import 'package:weather_app_test/domain/repositories/weather_repository.dart';
import 'package:weather_app_test/domain/usecases/get_current_weather.dart';
import 'package:weather_app_test/presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void initializeDependencies() {
  //bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  //usecase
  locator.registerLazySingleton(() => GetCurrentWeather(locator()));

  //repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      weatherRemoteDataSource: locator(),
    ),
  );

  //data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: locator()));

  //external
  locator.registerLazySingleton(() => http.Client());
}
