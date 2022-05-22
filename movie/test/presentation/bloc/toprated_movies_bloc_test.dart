import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';

import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/popularmovie/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/toprated_movie/toprated_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'toprated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main(){
  late TopRatedsMoviesBloc movieTopRatedBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp((){
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = TopRatedsMoviesBloc(mockGetTopRatedMovies);
  });

  test('the initial state should be TopRatedsMoviesEmpty', (){
    expect(movieTopRatedBloc.state, TopRatedsMoviesEmpty());
  });

  blocTest<TopRatedsMoviesBloc, TopRatedsMoviesState>(
    'should emit [Loading, Loaded] when PopularsMoviesGetEvent is added',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Right(testMovieList));
      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(TopRatedsMoviesGetEvent()),
    expect: () => [TopRatedsMoviesLoading(), TopRatedsMoviesLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
      return movieTopRatedBloc.state.props;
    },
  );

  blocTest<TopRatedsMoviesBloc, TopRatedsMoviesState>(
    'Should emit [Loading, Error] when GetNowPlayingMoviesEvent is added',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Left(ServerFailure('The Server is Failure')));
      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(TopRatedsMoviesGetEvent()),
    expect: () => [PopularsMoviesLoading(), PopularsMoviesError('The Server is Failure')],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
      return movieTopRatedBloc.state.props;
    },
  );
}