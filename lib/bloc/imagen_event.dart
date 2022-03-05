part of 'imagen_bloc.dart';

abstract class ImagenEvent extends Equatable {
  const ImagenEvent();

  @override
  List<Object> get props => [];
}

class ImagenJsonEvent extends ImagenEvent {}
