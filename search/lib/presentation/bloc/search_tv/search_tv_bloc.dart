import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecase/search_tv.dart';
import 'package:tvseries/domain/entities/tv.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvsBloc extends Bloc<SearchTvsEvent, SearchTvsState> {
  final SearchTv searchTv;

  SearchTvsBloc({
    required this.searchTv,
  }) : super(SearchTvsEmpty()) {
    on<TvSearchSetEmpty>((event, emit) => emit(SearchTvsEmpty()));

    on<TvSearchQueryEvent>((event, emit) async {
      emit(SearchTvsLoading());
      final result = await searchTv.execute(event.query);
      result.fold(
        (failure) {
          emit(SearchTvsError(failure.message));
        },
        (data) {
          emit(SearchTvsLoaded(data));
        },
      );
    });
  }
}
