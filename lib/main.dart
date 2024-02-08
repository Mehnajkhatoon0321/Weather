import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/Bloc/TheamsProvider/theam_provider.dart';

import 'package:weather/Screen/splash_screen.dart';

void main() {
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeProvider.themeData, // Apply the selected theme
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}