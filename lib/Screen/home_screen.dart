import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/Bloc/weatherbloc/weather_bloc.dart';
import 'package:weather/Screen/SettingScreen.dart';
import 'package:weather/Utils/flutter_font_style.dart';
import 'package:weather/Utils/static_methode.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final List<String> cities = [
    'Mumbai',
    'Delhi',
    'Bangalore',
    'Hyderabad',
    'Ahmedabad',
    'Chennai',
    'Kolkata',
    'Surat',
    'Pune',
    'Jaipur',
  ];
  bool _isIndicatorShown = false;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: Center(
              child: Text("Home", style: FTextStyle.appTitleStyle),
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen()));
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: cities.length,
          itemBuilder: (context, index) {
            final showLoading = index == 0 && !_isIndicatorShown;
            if (showLoading) {
              _isIndicatorShown = true;
            }
            return BlocProvider(
              create: (context) => WeatherBloc(),
              child: CityWeatherCard(city: cities[index], isLoadingShown: showLoading),
            );
          },
        ),
      ),
    );
  }
}

class CityWeatherCard extends StatelessWidget {
  final String city;
  final bool isLoadingShown;

  const CityWeatherCard({Key? key, required this.city, required this.isLoadingShown}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoadingShown) {
      BlocProvider.of<WeatherBloc>(context).add(LoadedEvent(city: city));
    }

    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading && isLoadingShown) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (state is NoInternetConnection) {
          return NWidgets.noNetwork(context);
        }
        else if (state is WeatherSuccess) {
          final weatherData = state.weatherData;
          final cityName = weatherData['location']['name'] ?? 'Unknown';
          final tempCelsius = weatherData['current']['temp_c'] ?? 'Unknown';
          final condition = weatherData['current']['condition']['text'] ?? 'Unknown';
          final haze = weatherData['current']['haze'] ?? 'Unknown';
          final windSpeed = weatherData['current']['wind_kph'] ?? 'Unknown';
          final humidity = weatherData['current']['humidity'] ?? 'Unknown';

          return Card(
            color: Colors.lightBlueAccent[100],
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'City: $cityName',
                          style: FTextStyle.subTitleStyle,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Temperature: $tempCelsius°C',
                          style: FTextStyle.subTitleStyle,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Condition: $condition',
                          style: FTextStyle.infoTitleStyle,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Haze: $haze',
                          style :FTextStyle.infoTitleStyle,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Wind Speed: $windSpeed km/h',
                          style:  FTextStyle.infoTitleStyle,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Humidity: $humidity%',
                          style: FTextStyle.infoTitleStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      "assets/images/cloudy.png",
                      height: 200,
                      width: 200,
                    ),
                  ),
                ],
              ),
            ),
          );

        } else if (state is WeatherError) {
          return Center(
            child: Text('Failed to load weather data for $city'),
          );
        } else {
          return Container(); // Empty container to prevent layout issues
        }
      },
    );
  }
}



