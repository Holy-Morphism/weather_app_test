import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_test/injection_container.dart';
import 'package:weather_app_test/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_test/presentation/screens/weather_screen.dart';

import 'config/theme/theme.dart';

void main() {
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => locator<WeatherBloc>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const WeatherScreen(),
        ));
  }
}
