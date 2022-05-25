part of 'toprated_tv_bloc.dart';

@immutable
abstract class TopRatedsTvsState  extends Equatable {}

class TopRatedsTvsEmpty  extends TopRatedsTvsState  {
  @override
  List<Object> get props => [];
}
class TopRatedsTvsLoading  extends TopRatedsTvsState  {
  @override
  List<Object> get props => [];
}
class TopRatedsTvsLoaded  extends TopRatedsTvsState  {
  final List<Tv> result;
  TopRatedsTvsLoaded (this.result);

  @override
  List<Object> get props => [result];
}
class TopRatedsTvsError  extends TopRatedsTvsState {

  @override
  List<Object> get props => [message];

    final String message;
  TopRatedsTvsError (this.message);
}