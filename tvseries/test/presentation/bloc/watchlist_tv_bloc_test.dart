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

@GenerateMocks([WatchlistTvsBloc,GetWatchlistTv,GetWatchListStatusTv,RemoveWatchlistTv,SaveWatchlistTv])
void main() {
  late MockGetWatchlistTv mockGetWatchlistTv;
  late MockGetWatchListStatusTv mockGetWatchListStatus;
  late MockSaveWatchlistTv mockSaveWatchlist;
  late MockRemoveWatchlistTv mockRemoveWatchlist;
  late WatchlistTvsBloc tvWatchlistBloc;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    mockGetWatchListStatus = MockGetWatchListStatusTv();
    mockSaveWatchlist = MockSaveWatchlistTv();
    mockRemoveWatchlist = MockRemoveWatchlistTv();
    tvWatchlistBloc = WatchlistTvsBloc(
      getWatchlistTv: mockGetWatchlistTv,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tvId = 1;

  test("initial state should be empty", () {
    expect(tvWatchlistBloc.state, WatchlistTvsEmpty());
  });

  blocTest<WatchlistTvsBloc, WatchlistTvsState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right(testWatchlistTvList));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListEvent()),
    expect: () =>
    [WatchlistTvsLoading(), WatchlistTvsLoaded(testWatchlistTvList)],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<WatchlistTvsBloc, WatchlistTvsState>(
    'Should emit [Loading, Error] when get watchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure("Can't get data")));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListEvent()),
    expect: () =>
    [WatchlistTvsLoading(), const WatchlistTvsError("Can't get data")],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<WatchlistTvsBloc, WatchlistTvsState>(
    'Should emit [Loaded] when get status tv watchlist is successful',
    build: () {
      when(mockGetWatchListStatus.execute(tvId))
          .thenAnswer((_) async => true);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(const GetStatusTvsEvent(tvId)),
    expect: () => [const WatchlistTvsStatusLoaded(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tvId));
    },
  );

  blocTest<WatchlistTvsBloc, WatchlistTvsState>(
    'Should emit [success] when add tv item to watchlist is successful',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right("Success"));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(const AddItemTvsEvent(testTvDetail)),
    expect: () => [const WatchlistTvsSuccess("Success")],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<WatchlistTvsBloc, WatchlistTvsState>(
    'Should emit [success] when remove tv item to watchlist is successful',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right("Removed"));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(const RemoveItemTvsEvent(testTvDetail)),
    expect: () => [const WatchlistTvsSuccess("Removed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<WatchlistTvsBloc, WatchlistTvsState>(
    'Should emit [error] when add tv item to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(const AddItemTvsEvent(testTvDetail)),
    expect: () => [const WatchlistTvsError("Failed")],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<WatchlistTvsBloc, WatchlistTvsState>(
    'Should emit [error] when remove tv item to watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(const RemoveItemTvsEvent(testTvDetail)),
    expect: () => [const WatchlistTvsError("Failed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvDetail));
    },
  );
}