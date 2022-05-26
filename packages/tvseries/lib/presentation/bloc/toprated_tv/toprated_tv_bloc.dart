import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tv.dart';

part 'toprated_tv_event.dart';
part 'toprated_tv_state.dart';

class TopRatedsTvsBloc
    extends Bloc<TopRatedsTvsEvent, TopRatedsTvsState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedsTvsBloc (this.getTopRatedTv)
      : super(TopRatedsTvsEmpty()) {
        on<TopRatedsTvsGetEvent>(_loadTopRated);
      }

      FutureOr<void> _loadTopRated(
        TopRatedsTvsGetEvent event,
        Emitter<TopRatedsTvsState> emit,
      ) async {
        emit(TopRatedsTvsLoading());
        final result = await getTopRatedTv.execute();
        result.fold(
          (failure) {
            emit(TopRatedsTvsError(failure.message));
          },
          (data) {
            data.isEmpty
            ? emit(TopRatedsTvsEmpty())
            : emit(TopRatedsTvsLoaded(data));
          },
        );
      }
    }