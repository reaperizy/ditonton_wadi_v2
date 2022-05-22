import 'dart:async';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'nowplaying_movie_event.dart';
part 'nowplaying_movie_state.dart';

class NowPlayingsMoviesBloc
    extends Bloc<NowPlayingsMoviesEvent, NowPlayingsMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingsMoviesBloc(this.getNowPlayingMovies)
      : super(NowPlayingsMoviesEmpty()) {
        on<NowPlayingsMoviesGetEvent>(_loadNowPlayingMovies);
      }

      FutureOr<void> _loadNowPlayingMovies(
        NowPlayingsMoviesGetEvent event,
        Emitter<NowPlayingsMoviesState> emit,
      ) async {
        emit(NowPlayingsMoviesLoading());
        final result = await getNowPlayingMovies.execute();
        result.fold(
          (failure) {
            emit(NowPlayingsMoviesError(failure.message));
          },
          (data) {
            data.isEmpty ? emit(NowPlayingsMoviesEmpty()) : emit(NowPlayingsMoviesLoaded(data));
          },
        );
      }
    }