import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/usecases/get_now_playing_tv.dart';

part 'onair_tv_event.dart';
part 'onair_tv_state.dart';

class OnAirsTvsBloc
    extends Bloc<OnAirsTvsEvent, OnAirsTvsState> {
  final GetNowPlayingTv  getOnAirTv;

  OnAirsTvsBloc(this.getOnAirTv)
      : super(OnAirsTvsEmpty()) {
        on<OnAirsTvsGetEvent>(_loadOnAirTv);
      }

      FutureOr<void> _loadOnAirTv(
        OnAirsTvsGetEvent event,
        Emitter<OnAirsTvsState> emit,
      ) async {
        emit(OnAirsTvsLoading());
        final result = await getOnAirTv.execute();
        result.fold(
          (failure) {
            emit(OnAirsTvsError(failure.message));
          },
          (data) {
            data.isEmpty
            ? emit(OnAirsTvsEmpty())
            : emit(OnAirsTvsLoaded(data));
          },
        );
      }
    }