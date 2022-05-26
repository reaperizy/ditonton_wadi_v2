import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/usecases/get_tv_recommendations.dart';
import 'package:tvseries/presentation/bloc/recommend_tv/reccomend_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'recommend_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])

const id = 1;

void main(){
  late RecommendTvsBloc   tvRecommendationBloc;
  late MockGetTvRecommendations  mockGetTvRecommendation;

  setUp((){
    mockGetTvRecommendation  = MockGetTvRecommendations();
    tvRecommendationBloc   = RecommendTvsBloc(mockGetTvRecommendation);
  });

  test('the initial state should be RecommendTvsEmpty', (){
    expect(tvRecommendationBloc.state, RecommendTvsEmpty());
  });

  blocTest<RecommendTvsBloc, RecommendTvsState>('should emit [Loading, Loaded] when GetRecommendTvsEvent is added',
    build: () {
      when(mockGetTvRecommendation.execute(id)).thenAnswer((_) async => Right(testTvList));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(GetRecommendTvsEvent(id)),
    expect: () => [RecommendTvsLoading(), RecommendTvsLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetTvRecommendation.execute(id));

      return tvRecommendationBloc.state.props;
    },
  );

  blocTest<RecommendTvsBloc, RecommendTvsState>('Should emit [Loading, Error] when GetRecommendTvsEvent is added',
    build: () {
      when(mockGetTvRecommendation.execute(id)).thenAnswer((_) async => const Left(ServerFailure('The Server is Failure')));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(GetRecommendTvsEvent(id)),
    expect: () => [RecommendTvsLoading(), RecommendTvsError('The Server is Failure')],
    verify: (bloc) {
      verify(mockGetTvRecommendation.execute(id));

      return tvRecommendationBloc.state.props;
    },
  );
}