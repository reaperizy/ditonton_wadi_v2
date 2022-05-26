part of 'popular_tv_bloc.dart';


@immutable
abstract class PopularsTvsState extends Equatable {}

class PopularsTvsEmpty  extends PopularsTvsState {
  @override
  List<Object> get props => [];
}
class PopularsTvsLoading    extends PopularsTvsState {
  @override
  List<Object> get props => [];
}
class PopularsTvsLoaded  extends PopularsTvsState {
  final List<Tv> result;
  PopularsTvsLoaded (this.result);

  @override
  List<Object> get props => [result];
}
class PopularsTvsError  extends PopularsTvsState{

  @override
  List<Object> get props => [message];

    final String message;
  PopularsTvsError (this.message);
}
