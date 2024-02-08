
import 'dart:convert';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  WeatherBloc() : super(WeatherInitial()) {

    on<LoadedEvent>((event, emit) async {
      const apiKey = '27bc8c7fa1a5430397792634240802';

      emit(WeatherLoading());
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        emit(NoInternetConnection( message: 'No internet connectio'));
        return;
      }
      try{
        var dio = Dio();
        var response = await dio.request(
          'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=${event.city},india',
          options: Options(
            method: 'GET',
          ),
        );

        if (response.statusCode == 200) {
          print(json.encode(response.data));
          var data = response.data;
          print("weather >>>>>>>$data");
          emit(WeatherSuccess(data));
        }
        else {
          print(response.statusMessage);
        }
      }catch(e){
        emit(WeatherError(message: ''));
      }
    });
  }
}


