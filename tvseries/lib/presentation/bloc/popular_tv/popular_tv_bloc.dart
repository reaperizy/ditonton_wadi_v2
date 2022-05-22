import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/usecases/get_popular_tv.dart';

part 'popular_tv_event.dart';

part 'popular_tv_state.dart';

class PopularsTvsBloc extends Bloc<PopularsTvsEvent, PopularsTvsState> {
  final GetPopularTv getPopularTv;

  PopularsTvsBloc(
    this.getPopularTv,
  ) : super(PopularsTvsEmpty()) {
    on<PopularsTvsGetEvent>((event, emit) async {
      emit(PopularsTvsLoading());
      final result = await getPopularTv.execute();
      result.fold(
        (failure) {
          emit(PopularsTvsError(failure.message));
        },
        (data) {
          emit(PopularsTvsLoaded(data));
        },
      );
    });
  }
}
