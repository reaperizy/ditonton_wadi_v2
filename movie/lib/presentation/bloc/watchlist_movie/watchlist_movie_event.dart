part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetListEvent extends WatchlistMoviesEvent {}

class GetStatusMovieEvent extends WatchlistMoviesEvent {
  final int id;

  const GetStatusMovieEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetStatusTvEvent extends WatchlistMoviesEvent {
  final int id;

  const GetStatusTvEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddItemMovieEvent extends WatchlistMoviesEvent {
  final MovieDetail movieDetail;

  const AddItemMovieEvent(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveItemMovieEvent extends WatchlistMoviesEvent {
  final MovieDetail movieDetail;

  const RemoveItemMovieEvent(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
