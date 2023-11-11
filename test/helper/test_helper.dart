import 'package:mockito/annotations.dart';
import 'package:weather_app_test/data/data_sources/remote_data_source.dart';
import 'package:weather_app_test/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_test/domain/usecases/get_current_weather.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeather,
  ],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {}
