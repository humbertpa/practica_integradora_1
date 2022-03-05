part of 'frase_bloc.dart';

abstract class FraseState extends Equatable {
  const FraseState();

  @override
  List<Object> get props => [];
}

class FraseInitial extends FraseState {}

class FraseError extends FraseState {
  final String errorMsg;
  FraseError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

class FraseSuccess extends FraseState {
  final Map successMsg;
  FraseSuccess({required this.successMsg});

  @override
  List<Object> get props => [successMsg];
}
