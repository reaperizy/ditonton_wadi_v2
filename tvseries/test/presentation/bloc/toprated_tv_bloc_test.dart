import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tv.dart';
import 'package:tvseries/presentation/bloc/toprated_tv/toprated_tv_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'toprated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])

void main(){
  late TopRatedsTvsBloc  tvTopRatedBloc;
  late MockGetTopRatedTv  mockGetTopRatedTv;

  setUp((){
    mockGetTopRatedTv  = MockGetTopRatedTv();
    tvTopRatedBloc  = TopRatedsTvsBloc(mockGetTopRatedTv);
  });

  test('the initial state should be TopRatedsTvsEmpty', (){
    expect(tvTopRatedBloc.state, TopRatedsTvsEmpty());
  });

  blocTest<TopRatedsTvsBloc, TopRatedsTvsState>('should emit [Loading, Loaded] when TopRatedsTvsGetEvent is added',
    build: () {
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(testTvList));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(TopRatedsTvsGetEvent()),
    expect: () => [TopRatedsTvsLoading(), TopRatedsTvsLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());

      return tvTopRatedBloc.state.props;
    },
  );

  blocTest<TopRatedsTvsBloc, TopRatedsTvsState>('Should emit [Loading, Error] when TopRatedsTvsGetEvent is added',
    build: () {
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => const Left(ServerFailure('The Server is Failure')));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(TopRatedsTvsGetEvent()),
    expect: () => [TopRatedsTvsLoading(), TopRatedsTvsError('The Server is Failure')],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );
}