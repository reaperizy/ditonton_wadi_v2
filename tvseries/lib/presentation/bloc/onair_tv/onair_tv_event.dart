part of 'onair_tv_bloc.dart';

abstract class OnAirsTvsEvent extends Equatable {
  const OnAirsTvsEvent();

  @override
  List<Object> get props => [];
}

class OnAirsTvsGetEvent extends OnAirsTvsEvent {}
