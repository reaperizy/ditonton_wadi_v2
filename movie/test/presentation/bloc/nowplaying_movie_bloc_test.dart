import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentation/bloc/nowplaying/nowplaying_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'nowplaying_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main(){
  late NowPlayingsMoviesBloc nowPlayingsMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp((){
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingsMoviesBloc = NowPlayingsMoviesBloc(mockGetNowPlayingMovies);
  });

  test('the initial state should be NowPlayingsMoviesEmpty', (){
    expect(nowPlayingsMoviesBloc.state, NowPlayingsMoviesEmpty());
  });

  blocTest<NowPlayingsMoviesBloc, NowPlayingsMoviesState>(
    'should emit [Loading, Loaded] when GetNowPlayingMoviesEvent is added',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => Right(testMovieList));
      return nowPlayingsMoviesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingsMoviesGetEvent()),
    expect: () => [NowPlayingsMoviesLoading(), NowPlayingsMoviesLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
      return nowPlayingsMoviesBloc.state.props;
    },
  );

  blocTest<NowPlayingsMoviesBloc, NowPlayingsMoviesState>(
    'Should emit [Loading, Error] when GetNowPlayingMoviesEvent is added',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => Left(ServerFailure('The Server is Failure')));
      return nowPlayingsMoviesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingsMoviesGetEvent()),
    expect: () => [NowPlayingsMoviesLoading(), NowPlayingsMoviesError('The Server is Failure')],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
      return nowPlayingsMoviesBloc.state.props;
    },
  );
}