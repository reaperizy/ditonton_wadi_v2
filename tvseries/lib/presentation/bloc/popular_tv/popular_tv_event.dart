part of 'popular_tv_bloc.dart';

abstract class PopularsTvsEvent extends Equatable {
  const PopularsTvsEvent();

  @override
  List<Object> get props => [];
}

class PopularsTvsGetEvent extends PopularsTvsEvent {}
