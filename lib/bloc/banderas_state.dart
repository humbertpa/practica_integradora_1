part of 'banderas_bloc.dart';

abstract class BanderasState extends Equatable {
  const BanderasState();

  @override
  List<Object> get props => [];
}

class BanderasInitial extends BanderasState {}

class BanderasError extends BanderasState {
  final String errorMsg;
  BanderasError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

class BanderasSuccess extends BanderasState {
  final Map successMsg;
  BanderasSuccess({required this.successMsg});

  @override
  List<Object> get props => [successMsg];
}
