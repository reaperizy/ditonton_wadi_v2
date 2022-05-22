import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularsMoviesBloc
    extends Bloc<PopularsMoviesEvent, PopularsMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularsMoviesBloc(this.getPopularMovies)
      : super(PopularsMoviesEmpty()) {
        on<PopularsMoviesGetEvent>(_loadPopularMovies);
      }

      FutureOr<void> _loadPopularMovies(
        PopularsMoviesGetEvent event,
        Emitter<PopularsMoviesState> emit,
      ) async {
        emit(PopularsMoviesLoading());
        final result = await getPopularMovies.execute();
        result.fold(
          (failure) {
            emit(PopularsMoviesError(failure.message));
          },
          (data) {
            data.isEmpty ? emit(PopularsMoviesEmpty()) : emit(PopularsMoviesLoaded(data));
          },
        );
      }
    }
