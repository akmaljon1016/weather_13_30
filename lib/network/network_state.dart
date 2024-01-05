part of 'network_cubit.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();
}

class NetworkInitial extends NetworkState {
  @override
  List<Object> get props => [];
}

class NetworkLoading extends NetworkState {
  @override
  List<Object> get props => [];
}

class NetworkSuccess extends NetworkState {
  final WeatherModel weather;

  const NetworkSuccess({required this.weather});

  @override
  List<Object> get props => [weather];
}

class NetworkError extends NetworkState {
  final String message;

  const NetworkError({required this.message});

  @override
  List<Object> get props => [message];
}
