import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/usecases/get_now_playing_tv.dart';
import 'package:tvseries/presentation/bloc/onair_tv/onair_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'onair_tv_bloc_test.mocks.dart';

@GenerateMocks([OnAirsTvsBloc,GetNowPlayingTv])
void main() {
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late OnAirsTvsBloc tvOnAirBloc;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    tvOnAirBloc = OnAirsTvsBloc(mockGetNowPlayingTv);
  });

  final tvList = <Tv>[];

  test("initial state should be empty", () {
    expect(tvOnAirBloc.state, OnAirsTvsEmpty());
  });

  group('On Air Tv BLoC Test', () {
    blocTest<OnAirsTvsBloc, OnAirsTvsState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(tvList));
        return tvOnAirBloc;
      },
      act: (bloc) => bloc.add(OnAirsTvsGetEvent()),
      expect: () => [OnAirsTvsLoading(), OnAirsTvsLoaded(tvList)],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      },
    );

    blocTest<OnAirsTvsBloc, OnAirsTvsState>(
      'Should emit [Loading, Error] when get now playing is unsuccessful',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return tvOnAirBloc;
      },
      act: (bloc) => bloc.add(OnAirsTvsGetEvent()),
      expect: () => [
        OnAirsTvsLoading(),
        const OnAirsTvsError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      },
    );
  },
  );
}