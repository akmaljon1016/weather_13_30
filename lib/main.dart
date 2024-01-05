import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/network/network_cubit.dart';

void main() {
  runApp(MaterialApp(
    home: BlocProvider(
      create: (context) => NetworkCubit(),
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NetworkCubit>(context).getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NetworkCubit, NetworkState>(
        builder: (context, state) {
          if (state is NetworkLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NetworkSuccess) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green[200]),
                    child: Column(
                      children: [
                        Image.network(
                            "https:${state.weather.current?.condition?.icon}"),
                        Text("${state.weather.current?.tempC} °C")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: state.weather.forecast?.forecastday?.length,
                        itemBuilder: (context, index) {
                      return  Container(
                        margin: EdgeInsets.all(20),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green[200]),
                        child: Column(
                          children: [
                            Image.network(
                                "https:${state.weather.forecast?.forecastday?[index].day?.condition?.icon}"),
                            Text("${state.weather.forecast?.forecastday?[index].day?.avgtempC} °C")
                          ],
                        ),
                      );
                    }),
                  )
                ],
              ),
            );
          } else if (state is NetworkError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
