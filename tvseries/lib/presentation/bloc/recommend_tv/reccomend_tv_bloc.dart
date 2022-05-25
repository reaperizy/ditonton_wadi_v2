import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/usecases/get_tv_recommendations.dart';

part 'reccomend_tv_event.dart';
part 'reccomend_tv_state.dart';

class RecommendTvsBloc
    extends Bloc<RecommendTvsEvent, RecommendTvsState> {
  final GetTvRecommendations  getTvRecommendations;

  RecommendTvsBloc (this.getTvRecommendations)
      : super(RecommendTvsEmpty()) {
        on<GetRecommendTvsEvent>(_loadRecommendMovies);
      }

      FutureOr<void> _loadRecommendMovies(
        GetRecommendTvsEvent event,
        Emitter<RecommendTvsState> emit,
      ) async {
        emit(RecommendTvsLoading());
        final result = await getTvRecommendations.execute(event.id);
        result.fold(
          (failure) {
            emit(RecommendTvsError(failure.message));
          },
          (data) {
            data.isEmpty
            ? emit(RecommendTvsEmpty())
            : emit(RecommendTvsLoaded(data));
          },
        );
      }
    }