part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvsState  extends Equatable {
  const WatchlistTvsState ();

  @override
  List<Object> get props => [];
}
class WatchlistTvsEmpty  extends WatchlistTvsState  {
  final String message = 'Watchlist Movies are Empty';
}
class WatchlistTvsLoading  extends WatchlistTvsState  {
  final String message = 'Watchlist Movies are Loading';
}
class WatchlistTvsError  extends WatchlistTvsState  {
  final String message;
  const WatchlistTvsError (this.message);
  @override
  List<Object> get props => [message];
}
class WatchlistTvsLoaded  extends WatchlistTvsState  {
  final List<Tv> result;
  const WatchlistTvsLoaded (this.result);
  @override
  List<Object> get props => [result];
}
class WatchlistTvsSuccess  extends WatchlistTvsState  {
  final String message;
  const WatchlistTvsSuccess  (this.message);
  @override
  List<Object> get props => [message];
}
class WatchlistTvsStatusLoaded  extends WatchlistTvsState  {
  final bool result;
  const WatchlistTvsStatusLoaded (this.result);
  @override
  List<Object> get props => [result];
}
