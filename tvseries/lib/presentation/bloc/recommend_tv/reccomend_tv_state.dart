part of 'reccomend_tv_bloc.dart';

@immutable
abstract class RecommendTvsState  extends Equatable {}

class RecommendTvsEmpty  extends RecommendTvsState  {
  @override
  List<Object> get props => [];
}
class RecommendTvsLoading  extends RecommendTvsState  {
  @override
  List<Object> get props => [];
}
class RecommendTvsLoaded   extends RecommendTvsState  {
  final List<Tv> tv;
  RecommendTvsLoaded (this.tv);

  @override
  List<Object> get props => [tv];
}
class RecommendTvsError  extends RecommendTvsState {

  @override
  List<Object> get props => [message];

    final String message;
  RecommendTvsError (this.message);
}
