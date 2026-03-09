import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required this.weatherService}) : super(WeatherInitialState());
  WeatherModel? weatherModel;
  WeatherService weatherService;
  void getWeather(String cityName) async {
    emit(WeatherLoadingState());
    try {
      weatherModel = await weatherService.getWeather(cityName: cityName);
      emit(WeatherSuccessState(weatherModel: weatherModel!));
    } catch (e) {
      emit(WeatherFaliureState(errormessage: e.toString()));
    }
  }
}
