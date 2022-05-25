import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:search/domain/usecase/search_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/presentation/bloc/search_movie/search_movie_bloc.dart';

import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main(){
  late SearchMoviesBloc  movieSearchBloc;
  late MockSearchMovies  mockSearchMovies;

    final testMovieModel = Movie(
        adult: false,
        backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
        genreIds: const [14, 28],
        id: 557,
        originalTitle: 'Spider-Man',
        overview:
            'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
        popularity: 60.441,
        posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
        releaseDate: '2002-05-01',
        title: 'Spider-Man',
        video: false,
        voteAverage: 7.2,
        voteCount: 13507,
      );

    final testMovieList = <Movie>[testMovieModel];
    const queryTest = "Spider-Man";

  setUp((){
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = SearchMoviesBloc(searchMovies : mockSearchMovies);
  });

  test('the initial state should be SearchMoviesEmpty', (){
    expect(movieSearchBloc.state, SearchMoviesEmpty());
  });

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'should emit [Loading, Loaded] when MovieSearchQueryEvent is added',
    build: () {
      when(mockSearchMovies.execute(queryTest)).thenAnswer((_) async => Right(testMovieList));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(const MovieSearchQueryEvent(queryTest)),
    wait: const Duration(milliseconds: 500),
    expect: () => [SearchMoviesLoading(), SearchMoviesLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockSearchMovies.execute(queryTest));
      return movieSearchBloc.state.props;
    },
  );

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'Should emit [Loading, Error] when MovieSearchQueryEvent is added',
    build: () {
      when(mockSearchMovies.execute(queryTest)).thenAnswer((_) async => const Left(ServerFailure('The Server is Failure')));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(const MovieSearchQueryEvent(queryTest)),
    expect: () => [SearchMoviesLoading(), const SearchMoviesError('The Server is Failure')],
    verify: (bloc) {
      verify(mockSearchMovies.execute(queryTest));
      return movieSearchBloc.state.props;
    },
  );
}