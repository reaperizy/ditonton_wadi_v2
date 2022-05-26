part of 'detail_tv_bloc.dart';

class GetDetailsTvsEvent  extends DetailsTvsEvent{
  final int id;
  GetDetailsTvsEvent (this.id);

  @override
  List<Object> get props => [id];
}

abstract class DetailsTvsEvent extends Equatable{}
