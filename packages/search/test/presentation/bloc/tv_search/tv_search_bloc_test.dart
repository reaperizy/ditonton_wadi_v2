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

@GenerateMocks([SearchTv])
void main(){
  late SearchTvsBloc  tvSearchBloc;
  late MockSearchTv  mockSearchTv;

    final testTvModel = Tv(
        backdropPath: '/suopoADq0k8YZr4dQXcU6pToj6s.jpg',
        genreIds: const [10765, 18, 10759, 9648],
        id: 1399,
        originalName: 'Game of Thrones',
        overview:
            "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
        popularity: 369.594,
        posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
        firstAirDate: '2011-04-17',
        name: 'Game of Thrones',
        voteAverage: 8.3,
        voteCount: 11504
    );

    final testTvList = <Tv>[testTvModel];
    const queryTest = "Game of Thrones";

  setUp((){
    mockSearchTv  = MockSearchTv();
    tvSearchBloc  = SearchTvsBloc(searchTv : mockSearchTv);
  });

  test('the initial state should be SearchTvsEmpty', (){
    expect(tvSearchBloc.state, SearchTvsEmpty());
  });

  blocTest<SearchTvsBloc, SearchTvsState>(
    'should emit [Loading, Loaded] when TvSearchQueryEvent is added',
    build: () {
      when(mockSearchTv.execute(queryTest)).thenAnswer((_) async => Right(testTvList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(const TvSearchQueryEvent(queryTest)),
    expect: () => [SearchTvsLoading(), SearchTvsLoaded(testTvList)],
    verify: (bloc) {
      verify(mockSearchTv.execute(queryTest));
      return tvSearchBloc.state.props;
    },
  );

  blocTest<SearchTvsBloc, SearchTvsState>(
    'Should emit [Loading, Error] when TvSearchQueryEvent is added',
    build: () {
      when(mockSearchTv.execute(queryTest)).thenAnswer((_) async => const Left(ServerFailure('The Server is Failure')));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(const TvSearchQueryEvent(queryTest)),
    expect: () => [SearchTvsLoading(), const SearchTvsError('The Server is Failure')],
    verify: (bloc) {
      verify(mockSearchTv.execute(queryTest));
      return tvSearchBloc.state.props;
    },
  );
}