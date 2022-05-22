import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/entities/tv_detail.dart';
import 'package:tvseries/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tv.dart';
import 'package:tvseries/domain/usecases/remove_watchlist_tv.dart';
import 'package:tvseries/domain/usecases/save_watchlist_tv.dart';

part 'watchlist_tv_event.dart';

part 'watchlist_tv_state.dart';

class WatchlistTvsBloc extends Bloc<WatchlistTvsEvent, WatchlistTvsState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistTv getWatchlistTv;
  final GetWatchListStatusTv getWatchListStatus;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  WatchlistTvsBloc({
    required this.getWatchlistTv,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(WatchlistTvsEmpty()) {
    on<GetListEvent>((event, emit) async {
      emit(WatchlistTvsLoading());
      final result = await getWatchlistTv.execute();
      result.fold(
        (failure) {
          emit(WatchlistTvsError(failure.message));
        },
        (data) {
          emit(WatchlistTvsLoaded(data));
        },
      );
    });

    on<GetStatusTvsEvent>((event, emit) async {
      final id = event.id;
      final result = await getWatchListStatus.execute(id);

      emit(WatchlistTvsStatusLoaded(result));
    });

    on<AddItemTvsEvent>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await saveWatchlist.execute(tvDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvsError(failure.message));
        },
        (successMessage) {
          emit(WatchlistTvsSuccess(successMessage));
        },
      );
    });

    on<RemoveItemTvsEvent>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await removeWatchlist.execute(tvDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvsError(failure.message));
        },
        (successMessage) {
          emit(WatchlistTvsSuccess(successMessage));
        },
      );
    });
  }
}
