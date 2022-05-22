import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/usecases/get_tv_recommendations.dart';

part 'reccomend_tv_event.dart';
part 'reccomend_tv_state.dart';

class RecommendTvsBloc extends Bloc<RecommendTvsEvent, RecommendTvsState> {
  final GetTvRecommendations getTvRecommendations;

  RecommendTvsBloc({
    required this.getTvRecommendations,
  }) : super(RecommendTvsEmpty()) {
    on<GetRecommendTvsEvent>((event, emit) async {
      emit(RecommendTvsLoading());
      final result = await getTvRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(RecommendTvsError(failure.message));
        },
        (data) {
          emit(RecommendTvsLoaded(data));
        },
      );
    });
  }
}
