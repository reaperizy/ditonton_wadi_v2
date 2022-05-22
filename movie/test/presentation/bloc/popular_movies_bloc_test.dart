import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/popularmovie/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main(){
  late PopularsMoviesBloc popularsMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp((){
    mockGetPopularMovies = MockGetPopularMovies();
    popularsMoviesBloc = PopularsMoviesBloc(mockGetPopularMovies);
  });

  test('the initial state should be PopularsMoviesEmpty', (){
    expect(popularsMoviesBloc.state, PopularsMoviesEmpty());
  });

  blocTest<PopularsMoviesBloc, PopularsMoviesState>(
    'should emit [Loading, Loaded] when PopularsMoviesGetEvent is added',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer((_) async => Right(testMovieList));
      return popularsMoviesBloc;
    },
    act: (bloc) => bloc.add(PopularsMoviesGetEvent()),
    expect: () => [PopularsMoviesLoading(), PopularsMoviesLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
      return popularsMoviesBloc.state.props;
    },
  );

  blocTest<PopularsMoviesBloc, PopularsMoviesState>(
    'Should emit [Loading, Error] when GetNowPlayingMoviesEvent is added',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer((_) async => Left(ServerFailure('The Server is Failure')));
      return popularsMoviesBloc;
    },
    act: (bloc) => bloc.add(PopularsMoviesGetEvent()),
    expect: () => [PopularsMoviesLoading(), PopularsMoviesError('The Server is Failure')],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
      return popularsMoviesBloc.state.props;
    },
  );
}