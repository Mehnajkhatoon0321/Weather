import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/Bloc/weatherbloc/weather_bloc.dart';
import 'package:weather/Screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
          () => navigateUser(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: SizedBox(
              height: 110,
              child: Image.asset(
                'assets/images/cloudy.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),

    );
  }

  navigateUser(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) {
          return BlocProvider(
            create: (context) => WeatherBloc(),
            child: const HomeScreen(),
          );
        }));
  }
}