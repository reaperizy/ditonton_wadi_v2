part of 'toprated_tv_bloc.dart';

abstract class TopRatedsTvsEvent extends Equatable {
  const TopRatedsTvsEvent();

  @override
  List<Object> get props => [];
}

class TopRatedsTvsGetEvent extends TopRatedsTvsEvent {}
