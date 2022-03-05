part of 'imagen_bloc.dart';

abstract class ImagenState extends Equatable {
  const ImagenState();

  @override
  List<Object> get props => [];
}

class ImagenInitial extends ImagenState {}

class ImagenSuccess extends ImagenState {
  final Map successMsg;

  ImagenSuccess({required this.successMsg});
  @override
  List<Object> get props => [successMsg];
}

class ImagenLoading extends ImagenState {}

class ImagenError extends ImagenState {
  final String errorMsg;

  ImagenError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
