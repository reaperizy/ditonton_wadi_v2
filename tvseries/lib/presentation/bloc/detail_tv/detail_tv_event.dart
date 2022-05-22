part of 'detail_tv_bloc.dart';

abstract class DetailsTvsEvent extends Equatable {
  const DetailsTvsEvent();

  @override
  List<Object> get props => [];
}

class GetDetailsTvsEvent extends DetailsTvsEvent {
  final int id;

  const GetDetailsTvsEvent(this.id);

  @override
  List<Object> get props => [];
}
