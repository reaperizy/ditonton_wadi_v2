import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tv.dart';
import 'package:tvseries/presentation/bloc/toprated_tv/toprated_tv_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'toprated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv, TopRatedsTvsBloc])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedsTvsBloc tvTopRatedBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    tvTopRatedBloc = TopRatedsTvsBloc(mockGetTopRatedTv);
  });

  final tvList = <Tv>[];

  test("initial state should be empty", () {
    expect(tvTopRatedBloc.state, TopRatedsTvsEmpty());
  });

  group('Top Rated Movies BLoC Test', () {
    blocTest<TopRatedsTvsBloc, TopRatedsTvsState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(tvList));
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(TopRatedsTvsGetEvent()),
      expect: () => [TopRatedsTvsLoading(), TopRatedsTvsLoaded(tvList)],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TopRatedsTvsBloc, TopRatedsTvsState>(
      'Should emit [Loading, Error] when get top rated is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(TopRatedsTvsGetEvent()),
      expect: () =>
      [TopRatedsTvsLoading(), const TopRatedsTvsError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );
  },);
}