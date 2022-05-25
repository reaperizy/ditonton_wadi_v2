import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tv.dart';
import 'package:tvseries/domain/usecases/remove_watchlist_tv.dart';
import 'package:tvseries/domain/usecases/save_watchlist_tv.dart';
import 'package:tvseries/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([WatchlistTvsBloc, GetWatchlistTv,
GetWatchListStatusTv, RemoveWatchlistTv, SaveWatchlistTv])
void main() {
  late MockGetWatchlistTv  mockGetWatchlistMovies;
  late MockGetWatchListStatusTv  mockGetWatchListStatus;
  late MockSaveWatchlistTv  mockSaveWatchlist;
  late MockRemoveWatchlistTv  mockRemoveWatchlist;
  late WatchlistTvsBloc  tvWatchlistBloc;

  const testTvId = 1;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistTv();
    mockGetWatchListStatus = MockGetWatchListStatusTv();
    mockSaveWatchlist = MockSaveWatchlistTv();
    mockRemoveWatchlist = MockRemoveWatchlistTv();
    tvWatchlistBloc = WatchlistTvsBloc(mockSaveWatchlist,
    mockRemoveWatchlist, mockGetWatchlistMovies, mockGetWatchListStatus
    );
  });

  test('initial state in watchlist movies should be empty', (){
    expect(tvWatchlistBloc.state, WatchlistTvsEmpty());
  });

  blocTest<WatchlistTvsBloc, WatchlistTvsState>('Should emit [Loading, Loaded] when data is added',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer((_) async => Right(testWatchlistTvList));
      return tvWatchlistBloc;
    },
    act: (bloc) async => bloc.add(GetListEvent()),
    expect: () => [
      WatchlistTvsLoading(),
      WatchlistTvsLoaded(testWatchlistTvList),],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());

      return GetListEvent().props;
    });

blocTest<WatchlistTvsBloc, WatchlistTvsState>('should emit [Loading, Error] when data is not added',
  build: (){
    when(mockGetWatchlistMovies.execute()).thenAnswer((_) async => const Left(ServerFailure('Server is Failure')));
    return tvWatchlistBloc;
  },
  act: (bloc) async => bloc.add(GetListEvent()),
  expect: () => [
    WatchlistTvsLoading(), const WatchlistTvsError('Server is Failure'),
  ],
  verify: (bloc) {
    verify(mockGetWatchlistMovies.execute());

    return GetListEvent().props;
  });

  blocTest<WatchlistTvsBloc, WatchlistTvsState>('should emit [Loading, Loaded] when data is added',
    build: () {
      when(mockGetWatchListStatus.execute(testTvId)).thenAnswer((_) async => true);
      return tvWatchlistBloc;
    },
    act: (bloc) async => bloc.add(const GetStatusTvsEvent(testTvId)),
    expect: () => [
      WatchlistTvsLoading(),
     const WatchlistTvsStatusLoaded(true),],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(testTvId));

      return const GetStatusTvsEvent(testTvId).props;
    });

  blocTest<WatchlistTvsBloc, WatchlistTvsState>('should emit [Loading, Error] when get watchlist status is not added',
    build: () {
      when(mockGetWatchListStatus.execute(testTvId)).thenAnswer((_) async => false);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(const GetStatusTvsEvent(testTvId)),
    expect: () => [
      WatchlistTvsLoading(),
      const WatchlistTvsStatusLoaded(false),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(testTvId));

      return const GetStatusTvsEvent(testTvId).props;
    });

  blocTest<WatchlistTvsBloc, WatchlistTvsState>('should emit [Loading, Loaded] when data is added',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail)).thenAnswer((_) async => const Right('Success'));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(const AddItemTvsEvent(testTvDetail)),
    expect: () => [
      const WatchlistTvsSuccess('Success'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvDetail));

      return const AddItemTvsEvent(testTvDetail).props;
    });

  blocTest<WatchlistTvsBloc, WatchlistTvsState>('should emit [Loading, Error] when data is not added',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail)).thenAnswer((_) async => const Left(DatabaseFailure('add data Failed')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(const AddItemTvsEvent(testTvDetail)),
    expect: () => [
      const WatchlistTvsError('add data Failed'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvDetail));

      return const AddItemTvsEvent(testTvDetail).props;
    });

  blocTest<WatchlistTvsBloc, WatchlistTvsState>('should emit [Loading, Removed] when data is Removed',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail)).thenAnswer((_) async => const Right('Remove Data Success'));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(const RemoveItemTvsEvent(testTvDetail)),
    expect: () => [
      const WatchlistTvsSuccess('Remove Data Success'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvDetail));

      return const RemoveItemTvsEvent(testTvDetail).props;
    });

  blocTest<WatchlistTvsBloc, WatchlistTvsState>('should emit [Loading, Error] when data is not Removed',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail)).thenAnswer((_) async => const Left(DatabaseFailure('Remove Data Failed')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(const RemoveItemTvsEvent(testTvDetail)),
    expect: () => [
      const WatchlistTvsError('Remove Data Failed'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvDetail));

      return const RemoveItemTvsEvent(testTvDetail).props;
    });
}
