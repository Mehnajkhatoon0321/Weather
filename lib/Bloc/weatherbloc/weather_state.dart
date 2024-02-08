part of 'weather_bloc.dart';


abstract class WeatherState {}

class WeatherInitial extends WeatherState {}
class WeatherLoading extends WeatherState {}
class WeatherSuccess extends WeatherState {
  final Map<String,dynamic> weatherData;

  WeatherSuccess(this.weatherData);

  @override
  List<Object> get props => [weatherData];
}



class WeatherError extends WeatherState {
  final String message;

  WeatherError({required this.message});
}
class NoInternetConnection extends WeatherState {

  final String message;

  NoInternetConnection({required this.message});
}