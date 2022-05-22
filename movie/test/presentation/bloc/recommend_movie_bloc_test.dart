import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/recommend_movie/reccomend_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recommend_movie_bloc_test.mocks.dart';


@GenerateMocks([GetMovieRecommendations])
void main(){
  late RecommendMoviesBloc  movieRecommendationBloc;
  late MockGetMovieRecommendations  mockGetMovieRecommendation;

  setUp((){
    mockGetMovieRecommendation  = MockGetMovieRecommendations();
    movieRecommendationBloc  = RecommendMoviesBloc(mockGetMovieRecommendation);
  });

  const id = 1;

  test('the initial state should be RecommendMoviesEmpty', (){
    expect(movieRecommendationBloc.state, RecommendMoviesEmpty());
  });

  blocTest<RecommendMoviesBloc, RecommendMoviesState>(
    'should emit [Loading, Loaded] when PopularsMoviesGetEvent is added',
    build: () {
      when(mockGetMovieRecommendation.execute(id)).thenAnswer((_) async => Right(testMovieList));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(GetRecommendMoviesEvent(id)),
    expect: () => [RecommendMoviesLoading(), RecommendMoviesLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(id));
      return movieRecommendationBloc.state.props;
    },
  );

  blocTest<RecommendMoviesBloc, RecommendMoviesState>(
    'Should emit [Loading, Error] when GetNowPlayingMoviesEvent is added',
    build: () {
      when(mockGetMovieRecommendation.execute(id)).thenAnswer((_) async => Left(ServerFailure('The Server is Failure')));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(GetRecommendMoviesEvent(id)),
    expect: () => [RecommendMoviesLoading(), RecommendMoviesError('The Server is Failure')],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(id));
      return movieRecommendationBloc.state.props;
    },
  );
}