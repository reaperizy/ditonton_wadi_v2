part of 'toprated_movie_bloc.dart';

@immutable
class TopRatedsMoviesGetEvent extends TopRatedsMoviesEvent {

  @override
  List<Object> get props => [];
}

abstract class TopRatedsMoviesEvent extends Equatable {
    const TopRatedsMoviesEvent();
}