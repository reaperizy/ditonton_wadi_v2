import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/usecases/get_tv_detail.dart';
import 'package:tvseries/presentation/bloc/detail_tv/detail_tv_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'detail_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail, DetailsTvsBloc])
void main() {
  late MockGetTvDetail mockGetTvDetail;
  late DetailsTvsBloc tvDetailBloc;
  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailBloc = DetailsTvsBloc(getTvDetail: mockGetTvDetail);
  });

  const tvId = 1;

  test("initial state should be empty", () {
    expect(tvDetailBloc.state, DetailsTvsEmpty());
  });

  group('Top Rated Movies BLoC Test', () {
    blocTest<DetailsTvsBloc, DetailsTvsState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTvDetail.execute(tvId))
            .thenAnswer((_) async => const Right(testTvDetail));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const GetDetailsTvsEvent(tvId)),
      expect: () => [DetailsTvsLoading(), const DetailTvsLoaded(testTvDetail)],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tvId));
      },
    );

    blocTest<DetailsTvsBloc, DetailsTvsState>(
      'Should emit [Loading, Error] when get detail is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tvId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const GetDetailsTvsEvent(tvId)),
      expect: () => [DetailsTvsLoading(), const DetailsTvsError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tvId));
      },
    );
  },);
}