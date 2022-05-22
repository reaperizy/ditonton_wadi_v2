import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:search/domain/usecase/search_movies.dart';
import 'package:search/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMoviesBloc,SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;
  late SearchMoviesBloc movieSearchBloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = SearchMoviesBloc(
      searchMovies: mockSearchMovies,
    );
  });

  const query = "originalTitle";
  final movieList = <Movie>[];

  test("initial state should be empty", () {
    expect(movieSearchBloc.state, SearchMoviesEmpty());
  });

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(query))
          .thenAnswer((_) async => Right(movieList));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(const MovieSearchQueryEvent(query)),
    expect: () => [SearchMoviesLoading(), SearchMoviesLoaded(movieList)],
    verify: (bloc) {
      verify(mockSearchMovies.execute(query));
    },
  );

  group('Search Movies BLoC Test', () {
    blocTest<SearchMoviesBloc, SearchMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(query))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(const MovieSearchQueryEvent(query)),
      expect: () =>
      [SearchMoviesLoading(), const SearchMoviesError('Server Failure')],
      verify: (bloc) {
        verify(mockSearchMovies.execute(query));
      },
    );
  },
  );
}