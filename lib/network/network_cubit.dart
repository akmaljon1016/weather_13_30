import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/model/weather_model.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit() : super(NetworkInitial());

  Dio dio = Dio();

  void getWeather() async {
    emit(NetworkLoading());
    try {
      var response = await dio.get(
          "https://api.weatherapi.com/v1/forecast.json?key=acb4a4de25aa41b784651422200510&q=Fergana&days=3");
      if (response.statusCode == 200) {
        emit(NetworkSuccess(weather: WeatherModel.fromJson(response.data)));
      } else {
        emit(NetworkError(message: "Noma'lum xatolik"));
      }
    } catch (e) {
      emit(NetworkError(message: e.toString()));
    }
  }
}
