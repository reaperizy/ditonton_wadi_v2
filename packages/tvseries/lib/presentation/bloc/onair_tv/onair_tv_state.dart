part of 'onair_tv_bloc.dart';

@immutable
abstract class OnAirsTvsState  extends Equatable {}

class OnAirsTvsEmpty  extends OnAirsTvsState  {
  @override
  List<Object> get props => [];
}
class OnAirsTvsLoading  extends OnAirsTvsState  {
  @override
  List<Object> get props => [];
}
class OnAirsTvsLoaded  extends OnAirsTvsState  {
  final List<Tv> result;
  OnAirsTvsLoaded(this.result);

  @override
  List<Object> get props => [result];
}
class OnAirsTvsError extends OnAirsTvsState {

  @override
  List<Object> get props => [message];

    final String message;
  OnAirsTvsError(this.message);
}
