part of 'banderas_bloc.dart';

abstract class BanderasEvent extends Equatable {
  const BanderasEvent();

  @override
  List<Object> get props => [];
}

class BanderasJsonEvent extends BanderasEvent {}
