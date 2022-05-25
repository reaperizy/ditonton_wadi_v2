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
class WatchlistTvsBloc  extends Bloc<WatchlistTvsEvent, WatchlistTvsState>{
  static const watchlistRemoveSuccessMessage
        = 'Successfully removed from watchlist';
  static const watchlistAddSuccessMessage
        = 'Successfully added to watchlist';
  final SaveWatchlistTv  saveWatchlist;
  final RemoveWatchlistTv  removeWatchlist;
  final GetWatchlistTv  getWatchlistTv;
  final GetWatchListStatusTv  getWatchListStatus;

  WatchlistTvsBloc(
    this.saveWatchlist,
    this.removeWatchlist,
    this.getWatchlistTv,
    this.getWatchListStatus
  ) : super(WatchlistTvsEmpty()) {
    on<GetListEvent>((event, emit) async {
      emit(WatchlistTvsLoading());
      final result = await getWatchlistTv.execute();
      result.fold(
        (failure) {
          emit(WatchlistTvsError(failure.message));
        },
        (data) {
          data.isEmpty
          ? emit(WatchlistTvsEmpty())
          : emit(WatchlistTvsLoaded(data));
        }
      );
    });
    on<GetStatusTvsEvent>((event, emit) async {
      emit(WatchlistTvsLoading());
      final result = await getWatchListStatus.execute(event.id);
      emit(WatchlistTvsStatusLoaded (result));
    });
    on<AddItemTvsEvent>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await saveWatchlist.execute(tvDetail);
      result.fold(
        (failure){
          emit(WatchlistTvsError(failure.message));
        },
        (successMessage){
          emit(WatchlistTvsSuccess (successMessage));
        },
      );
    });
    on<RemoveItemTvsEvent>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await removeWatchlist.execute(tvDetail);
      result.fold(
        (failure){
          emit(WatchlistTvsError(failure.message));
        },
        (successMessage){
          emit(WatchlistTvsSuccess (successMessage));
        },
      );
    });
  }
}