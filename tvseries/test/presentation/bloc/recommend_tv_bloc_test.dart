import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/usecases/get_tv_recommendations.dart';
import 'package:tvseries/presentation/bloc/recommend_tv/reccomend_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommend_tv_bloc_test.mocks.dart';

@GenerateMocks([RecommendTvsBloc,GetTvRecommendations])
void main() {
  late MockGetTvRecommendations mockGetTvRecommendation;
  late RecommendTvsBloc tvRecommendationBloc;

  setUp(() {
    mockGetTvRecommendation = MockGetTvRecommendations();
    tvRecommendationBloc = RecommendTvsBloc(
      getTvRecommendations: mockGetTvRecommendation,
    );
  });

  test("initial state should be empty", () {
    expect(tvRecommendationBloc.state, RecommendTvsEmpty());
  });

  const tvId = 1;
  final tvList = <Tv>[];

  blocTest<RecommendTvsBloc, RecommendTvsState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTvRecommendation.execute(tvId))
          .thenAnswer((_) async => Right(tvList));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(const GetRecommendTvsEvent(tvId)),
    expect: () =>
    [RecommendTvsLoading(), RecommendTvsLoaded(tvList)],
    verify: (bloc) {
      verify(mockGetTvRecommendation.execute(tvId));
    },
  );

  group('Recommendation Tv BLoC Test', () {
    blocTest<RecommendTvsBloc, RecommendTvsState>(
      'Should emit [Loading, Error] when get recommendation is unsuccessful',
      build: () {
        when(mockGetTvRecommendation.execute(tvId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(const GetRecommendTvsEvent(tvId)),
      expect: () => [
        RecommendTvsLoading(),
        const RecommendTvsError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendation.execute(tvId));
      },
    );
  },
  );
}