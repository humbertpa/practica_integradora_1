part of 'time_bloc.dart';

abstract class TimeState extends Equatable {
  const TimeState();

  @override
  List<Object> get props => [];
}

class TimeInitial extends TimeState {}

class TimeError extends TimeState {
  final String errorMsg;
  TimeError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

class TimeSuccess extends TimeState {
  final Map successMsg;
  TimeSuccess({required this.successMsg});

  @override
  List<Object> get props => [successMsg];
}
