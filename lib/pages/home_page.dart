import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubit/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/widgets/home_page_body.dart';
import 'package:weather_app/widgets/no_weather_body.dart';

class HoemPage extends StatelessWidget {
  HoemPage({Key? key}) : super(key: key);
  WeatherModel? weatherModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchPage(),
              ));
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        if (state is WeatherSuccessState) {
          weatherModel=  BlocProvider.of<WeatherCubit>(context).weatherModel;
          return HomePageBody(weatherModel: weatherModel!);
        } else if (state is WeatherFaliureState) {
          return Center(
            child: Text(
              state.errormessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is WeatherLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const NoWeatherBody();
        }
      }),
    );
  }
}
