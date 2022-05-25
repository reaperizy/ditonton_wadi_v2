import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:search/domain/usecase/search_movies.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;

  SearchMoviesBloc({required this.searchMovies,})
  : super(SearchMoviesEmpty()){on<MovieSearchSetEmpty>
  ((event, emit) => emit(SearchMoviesEmpty()));

    on<MovieSearchQueryEvent>((event, emit) async {
      emit(SearchMoviesLoading());

      final result = await searchMovies.execute(event.query);

      result.fold(
        (failure) {
          emit(SearchMoviesError(failure.message));
        },(data) { data.isEmpty
          ? emit(SearchMoviesEmpty())
          : emit(SearchMoviesLoaded(data));
        },
      );
    });
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) =>
  events.debounceTime(duration).flatMap(mapper);
}
