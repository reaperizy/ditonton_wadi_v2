part of 'detail_tv_bloc.dart';

abstract class DetailsTvsState extends Equatable {}

class DetailsTvsEmpty extends DetailsTvsState {
  @override
  List<Object> get props => [];
}
class DetailsTvsLoading extends DetailsTvsState {
  @override
  List<Object> get props => [];
}
class DetailTvsLoaded extends DetailsTvsState {
  final TvDetail tvDetail;
  DetailTvsLoaded(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
class DetailsTvsError extends DetailsTvsState{

  @override
  List<Object> get props => [message];

    final String message;
  DetailsTvsError(this.message);
}