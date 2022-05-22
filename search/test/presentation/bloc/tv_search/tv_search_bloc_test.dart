import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:search/domain/usecase/search_tv.dart';
import 'package:search/presentation/bloc/search_tv/search_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvsBloc,SearchTv])
void main() {
  late MockSearchTv mockSearchTv;
  late SearchTvsBloc tvSearchBloc;

  setUp(() {
    mockSearchTv = MockSearchTv();
    tvSearchBloc = SearchTvsBloc(
      searchTv: mockSearchTv,
    );
  });

  const query = "originalTitle";
  final tvList = <Tv>[];

  test("initial state should be empty", () {
    expect(tvSearchBloc.state, SearchTvsEmpty());
  });

  blocTest<SearchTvsBloc, SearchTvsState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchTv.execute(query))
          .thenAnswer((_) async => Right(tvList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(const TvSearchQueryEvent(query)),
    expect: () => [SearchTvsLoading(), SearchTvsLoaded(tvList)],
    verify: (bloc) {
      verify(mockSearchTv.execute(query));
    },
  );

  group('Search Tv BLoC Test', () {
    blocTest<SearchTvsBloc, SearchTvsState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchTv.execute(query))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return tvSearchBloc;
      },
      act: (bloc) => bloc.add(const TvSearchQueryEvent(query)),
      expect: () =>
      [SearchTvsLoading(), const SearchTvsError('Server Failure')],
      verify: (bloc) {
        verify(mockSearchTv.execute(query));
      },
    );
  },
  );
}