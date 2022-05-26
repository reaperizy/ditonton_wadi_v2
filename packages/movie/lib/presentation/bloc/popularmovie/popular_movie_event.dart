part of 'popular_movie_bloc.dart';

abstract class PopularsMoviesEvent extends Equatable {
  const PopularsMoviesEvent();

  @override
  List<Object> get props => [];
}

class PopularsMoviesGetEvent extends PopularsMoviesEvent {}
