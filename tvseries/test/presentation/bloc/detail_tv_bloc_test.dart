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

@GenerateMocks([GetTvDetail])
void main(){
  late DetailsTvsBloc tvDetailBloc;
  late MockGetTvDetail  mockGetTvDetail;
  const testTvId = 1;

  setUp((){
    mockGetTvDetail  = MockGetTvDetail();
    tvDetailBloc = DetailsTvsBloc(
      getTvDetail: mockGetTvDetail);
  });

  test('the initial state should be MoviesDetailsEmpty', (){
    expect(tvDetailBloc.state, DetailsTvsEmpty());
  });

  blocTest<DetailsTvsBloc, DetailsTvsState>('should emit [Loading, Loaded] when GetDetailsTvsEvent is added',
    build: () {
      when(mockGetTvDetail.execute(testTvId)).thenAnswer((_) async => const Right(testTvDetail));
      return tvDetailBloc;
    },
    act: (bloc) {
      bloc.add(GetDetailsTvsEvent(testTvId));
    }, expect: () { return [DetailsTvsLoading(),
      DetailTvsLoaded(testTvDetail)
    ];}, verify: (bloc) {
      verify(mockGetTvDetail.execute(testTvId));
      return tvDetailBloc.state.props;
    }
  );

  blocTest<DetailsTvsBloc, DetailsTvsState>('should emit [Loading, Error] when GetDetailsMoviesEvent is added',
    build: () {
      when(mockGetTvDetail.execute(testTvId)).thenAnswer((_) async => const Left(ServerFailure('The Server is Failure')));
      return tvDetailBloc;
    },
    act: (bloc) {
      bloc.add(GetDetailsTvsEvent(testTvId));
    }, expect: () { return [DetailsTvsLoading(),
      DetailsTvsError('The Server is Failure')
    ];}, verify: (bloc) {
      verify(mockGetTvDetail.execute(testTvId));

      return tvDetailBloc.state.props;
    }
  );
}