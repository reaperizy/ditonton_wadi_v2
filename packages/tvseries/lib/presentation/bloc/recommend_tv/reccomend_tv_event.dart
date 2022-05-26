part of 'reccomend_tv_bloc.dart';

class GetRecommendTvsEvent  extends RecommendTvsEvent {
  final int id;
  GetRecommendTvsEvent (this.id);

  @override
  List<Object> get props => [id];
}
abstract class RecommendTvsEvent  extends Equatable{}

