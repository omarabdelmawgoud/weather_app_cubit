
class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherSuccessState extends WeatherState {
}

class WeatherLoadingState extends WeatherState {}

class WeatherFaliureState extends WeatherState {
  final String errormessage;

  WeatherFaliureState({required this.errormessage});
}
