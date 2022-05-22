import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/tv_detail.dart';
import 'package:tvseries/domain/usecases/get_tv_detail.dart';

part 'detail_tv_event.dart';
part 'detail_tv_state.dart';

class DetailsTvsBloc extends Bloc<DetailsTvsEvent, DetailsTvsState> {
  final GetTvDetail getTvDetail;

  DetailsTvsBloc({
    required this.getTvDetail,
  }) : super(DetailsTvsEmpty()) {
    on<GetDetailsTvsEvent>((event, emit) async {
      emit(DetailsTvsLoading());
      final result = await getTvDetail.execute(event.id);
      result.fold(
        (failure) {
          emit(DetailsTvsError(failure.message));
        },
        (data) {
          emit(DetailTvsLoaded(data));
        },
      );
    });
  }
}
