import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/usecases/get_now_playing_tv.dart';
import 'package:tvseries/presentation/bloc/onair_tv/onair_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'onair_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])

void main(){
  late OnAirsTvsBloc  tvOnAirBloc;
  late MockGetNowPlayingTv  mockGetNowPlayingTv;

  setUp((){
    mockGetNowPlayingTv  = MockGetNowPlayingTv();
    tvOnAirBloc  = OnAirsTvsBloc(mockGetNowPlayingTv);
  });

  test('the initial state should be OnAirsTvsEmpty', (){
    expect(tvOnAirBloc.state, OnAirsTvsEmpty());
  });

  blocTest<OnAirsTvsBloc, OnAirsTvsState>('should emit [Loading, Loaded] when OnAirsTvsGetEvent is added',
    build: () {
      when(mockGetNowPlayingTv.execute()).thenAnswer((_) async => Right(testTvList));
      return tvOnAirBloc;
    },
    act: (bloc) => bloc.add(OnAirsTvsGetEvent()),
    expect: () => [OnAirsTvsLoading(), OnAirsTvsLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());

      return tvOnAirBloc.state.props;
    },
  );

  blocTest<OnAirsTvsBloc, OnAirsTvsState>('Should emit [Loading, Error] when OnAirsTvsGetEvent is added',
    build: () {
      when(mockGetNowPlayingTv.execute()).thenAnswer((_) async => const Left(ServerFailure('The Server is Failure')));
      return tvOnAirBloc;
    },
    act: (bloc) => bloc.add(OnAirsTvsGetEvent()),
    expect: () => [OnAirsTvsLoading(), OnAirsTvsError('The Server is Failure')],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());

      return tvOnAirBloc.state.props;
    },
  );
}