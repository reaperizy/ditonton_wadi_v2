import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/usecases/get_popular_tv.dart';

part 'popular_tv_event.dart';

part 'popular_tv_state.dart';

class PopularsTvsBloc
    extends Bloc<PopularsTvsEvent, PopularsTvsState> {
  final GetPopularTv  getPopularTv;

  PopularsTvsBloc(this.getPopularTv)
      : super(PopularsTvsEmpty()) {
        on<PopularsTvsGetEvent>(_loadPopularTvs);
      }

      FutureOr<void> _loadPopularTvs(
        PopularsTvsGetEvent event,
        Emitter<PopularsTvsState> emit,
      ) async {
        emit(PopularsTvsLoading());
        final result = await getPopularTv.execute();
        result.fold(
          (failure) {
            emit(PopularsTvsError(failure.message));
          },
          (data) {
            data.isEmpty
            ? emit(PopularsTvsEmpty())
            : emit(PopularsTvsLoaded(data));
          },
        );
      }
    }
