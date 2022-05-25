import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/usecases/get_popular_tv.dart';
import 'package:tvseries/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])

void main(){
  late PopularsTvsBloc  tvPopularBloc;
  late MockGetPopularTv  mockGetPopularTv;

  setUp((){
    mockGetPopularTv  = MockGetPopularTv();
    tvPopularBloc  = PopularsTvsBloc(mockGetPopularTv);
  });

  test('the initial state should be PopularsTvsEmpty', (){
    expect(tvPopularBloc.state, PopularsTvsEmpty());
  });

  blocTest<PopularsTvsBloc, PopularsTvsState>('should emit [Loading, Loaded] when PopularsTvsGetEvent is added',
    build: () {
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(testTvList));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(PopularsTvsGetEvent()),
    expect: () => [PopularsTvsLoading(), PopularsTvsLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());

      return tvPopularBloc.state.props;
    },
  );

  blocTest<PopularsTvsBloc, PopularsTvsState>('Should emit [Loading, Error] when PopularsTvsGetEvent is added',
    build: () {
      when(mockGetPopularTv.execute()).thenAnswer((_) async => const Left(ServerFailure('The Server is Failure')));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(PopularsTvsGetEvent()),
    expect: () => [PopularsTvsLoading(), PopularsTvsError('The Server is Failure')],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());

      return tvPopularBloc.state.props;
    },
  );
}