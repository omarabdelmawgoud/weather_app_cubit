import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubit/weather_cubit/weather_state.dart';
import 'package:weather_app/pages/search_page.dart';

class HoemPage extends StatelessWidget {
  final bool ok = true;

  const HoemPage({Key? key}) : super(key: key);
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
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                state.weatherModel.getThemeColor(),
                state.weatherModel.getThemeColor()[300]!,
                state.weatherModel.getThemeColor()[100]!,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 3,
                ),
                Text(
                  state.weatherModel.cityName,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'updated at : ${state.weatherModel.date.hour.toString()}:${state.weatherModel.date.minute.toString()}',
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(state.weatherModel.getImage()),
                    Text(
                      state.weatherModel.temp.toInt().toString(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        Text('maxTemp :${state.weatherModel.maxTemp.toInt()}'),
                        Text('minTemp : ${state.weatherModel.minTemp.toInt()}'),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  state.weatherModel.weatherStateName,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(
                  flex: 5,
                ),
              ],
            ),
          );
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
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'there is no weather 😔 start',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  'searching now 🔍',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )
              ],
            ),
          );
        }
      }),
    );
  }
}
