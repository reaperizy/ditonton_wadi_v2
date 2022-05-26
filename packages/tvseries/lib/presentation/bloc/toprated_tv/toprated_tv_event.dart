part of 'toprated_tv_bloc.dart';

@immutable
class TopRatedsTvsGetEvent extends TopRatedsTvsEvent {

  @override
  List<Object> get props => [];
}

abstract class TopRatedsTvsEvent extends Equatable {
    const TopRatedsTvsEvent();
}