part of 'weather_bloc.dart';

abstract class WeatherEvent {}
class LoadedEvent extends WeatherEvent {
  final String city;

  LoadedEvent({required this.city});
}