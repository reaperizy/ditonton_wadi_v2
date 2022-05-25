import 'dart:io';

import 'package:core/data/models/genre_model.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/data/models/tv_detail_model.dart';
import 'package:tvseries/data/models/tv_model.dart';
import 'package:tvseries/data/repositories/tv_repository_impl.dart';
import 'package:tvseries/domain/entities/tv.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late TelevisionRepositoryImpl repository;
  late MockTelevisionRemoteDataSource mockRemoteDataSource;
  late MockTelevisionLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTelevisionRemoteDataSource();
    mockLocalDataSource = MockTelevisionLocalDataSource();
    repository = TelevisionRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tTvModel = TvModel(
    backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
    genreIds: [10765, 10759, 18],
    id: 1399,
    originalName: 'Game of Thrones',
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 29.780826,
    posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
    firstAirDate: '2011-04-17',
    name: 'Game of Thrones',
    voteAverage: 7.91,
    voteCount: 1172,
  );

  final tTv = Tv(
    backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
    genreIds: const [10765, 10759, 18],
    id: 1399,
    originalName: 'Game of Thrones',
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 29.780826,
    posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
    firstAirDate: '2011-04-17',
    name: 'Game of Thrones',
    voteAverage: 7.91,
    voteCount: 1172,
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('Now Playing Tv', () {
    test('should return remote data when the call to remote data source is successful',
        () async {

      // arrange
      when(mockRemoteDataSource.getNowPlayingTv())
          .thenAnswer((_) async => tTvModelList);

      // act
      final result = await repository.getNowPlayingTv();

      // assert
      verify(mockRemoteDataSource.getNowPlayingTv());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);

      expect(
        resultList,
        tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {

      // arrange
      when(mockRemoteDataSource.getNowPlayingTv()).thenThrow(ServerException());

      // act
      final result = await repository.getNowPlayingTv();

      // assert
      verify(mockRemoteDataSource.getNowPlayingTv());

      expect(
        result,
        equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {

      // arrange
      when(mockRemoteDataSource.getNowPlayingTv()).thenThrow(const SocketException('Failed to connect to the networks'));

      // act
      final result = await repository.getNowPlayingTv();

      // assert
      verify(mockRemoteDataSource.getNowPlayingTv());

      expect(
          result,
          equals(const Left( ConnectionFailure('Failed to connect to the networks'))));
    });
  });

  group('Popular Tv', () {
    test('should return Tv list when call to data source is success', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv()).thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTv();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);

      expect(
        resultList,
        tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',() async {

      // arrange
      when(mockRemoteDataSource.getPopularTv()).thenThrow(ServerException());

      // act
      final result = await repository.getPopularTv();

      // assert
      expect(
        result,
        const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',() async {

      // arrange
      when(mockRemoteDataSource.getPopularTv()).thenThrow(const SocketException('Failed to connect to the networks'));

      // act
      final result = await repository.getPopularTv();

      // assert
      expect(
        result,
        const Left(ConnectionFailure('Failed to connect to the networks')));
    });
  });

  group('Top Rated Tv', () {
    test('should return Tv list when call to data source is successful',() async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv()).thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTopRatedTv();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(
        resultList,
        tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',() async {

      // arrange
      when(mockRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());

      // act
      final result = await repository.getTopRatedTv();

      // assert
      expect(
        result,
        const Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when device is not connected to the internet',() async {

      // arrange
      when(mockRemoteDataSource.getTopRatedTv())
          .thenThrow(const SocketException('Failed to connect to the networks'));

      // act
      final result = await repository.getTopRatedTv();

      // assert
      expect(
        result,
        const Left(ConnectionFailure('Failed to connect to the networks')));
    });
  });

  group('Get Tv Detail', () {
    const tId = 1;
    const tTvResponse = TvDetailResponse(
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      originalLanguage: 'en',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      status: 'Status',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      tagline: 'Tagline',
      name: 'name',
      type: 'type',
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Tv data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId)).thenAnswer((_) async => tTvResponse);
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(
        result,
        equals(const Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful', () async {

      // arrange
      when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(ServerException());

      // act
      final result = await repository.getTvDetail(tId);

      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(
        result,
        equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',() async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(const SocketException('Failed to connect to the networks'));

      // act
      final result = await repository.getTvDetail(tId);

      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));

      expect(
        result,
        equals(const Left(ConnectionFailure('Failed to connect to the networks'))));
    });
  });

  group('Get Tv Recommendations', () {
    final tTvList = <TvModel>[];
    const tId = 1;

    test('should return data (tv list) when the call is successful', () async {

      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId)).thenAnswer((_) async => tTvList);

      // act
      final result = await repository.getTvRecommendations(tId);

      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);

      expect(
        resultList,
        equals(tTvList));
    });

    test('should return server failure when call to remote data source is unsuccessful',() async {

      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId)).thenThrow(ServerException());

      // act
      final result = await repository.getTvRecommendations(tId);

      // assertbuild runner
      verify(mockRemoteDataSource.getTvRecommendations(tId));

      expect(
        result,
        equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId)).thenThrow(const SocketException('Failed to connect to the networks'));
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(
          result,
          equals(const Left(ConnectionFailure('Failed to connect to the networks'))));
    });
  });

  group('Seach Tv', () {
    const tQuery = 'game of thrones';

    test('should return tv list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery))
          .thenAnswer((_) async => tTvModelList);

      // act
      final result = await repository.searchTv(tQuery);

      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);

      expect(
        resultList,
        tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',() async {

      // arrange
      when(mockRemoteDataSource.searchTv(tQuery)).thenThrow(ServerException());

      // act
      final result = await repository.searchTv(tQuery);

      // assert
      expect(
        result,
        const Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when device is not connected to the internet',() async {

      // arrange
      when(mockRemoteDataSource.searchTv(tQuery)).thenThrow(const SocketException('Failed to connect to the networks'));

      // act
      final result = await repository.searchTv(tQuery);

      // assert
      expect(
        result,
        const Left(ConnectionFailure('Failed to connect to the networks')));
    });
  });

  group('save watchlist tv', () {
    test('should return success message when saving successful', () async {

      // arrange
      when(mockLocalDataSource.insertWatchlistTv(testTvTable)).thenAnswer((_) async => 'Added to Watchlist');

      // act
      final result = await repository.saveWatchlistTv(testTvDetail);

      // assert
      expect(
        result,
        const Right('Added to Watchlist'));
    });

    test('should return Database Failure when saving unsuccessful', () async {

      // arrange
      when(mockLocalDataSource.insertWatchlistTv(testTvTable)).thenThrow(DatabaseException('Failed to add watchlist'));

      // act
      final result = await repository.saveWatchlistTv(testTvDetail);

      // assert
      expect(
        result,
        const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist tv', () {
    test('should return success message when remove successful', () async {

      // arrange
      when(mockLocalDataSource.removeWatchlistTv(testTvTable)).thenAnswer((_) async => 'Removed from watchlist');

      // act
      final result = await repository.removeWatchlistTv(testTvDetail);

      // assert
      expect(
        result,
        const Right('Removed from watchlist'));
    });

    test('should return Database Failure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTv(testTvTable)).thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlistTv(testTvDetail);
      // assert
      expect(
        result,
        const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;

      when(mockLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);

      // act
      final result = await repository.isAddedToWatchlistTv(tId);

      // assert
      expect(
        result,
        false);
    });
  });

  group('get watchlist tv', () {
    test('should return list of Tv', () async {

      // arrange
      when(mockLocalDataSource.getWatchlistTv()).thenAnswer((_) async => [testTvTable]);

      // act
      final result = await repository.getWatchlistTv();

      // assert
      final resultList = result.getOrElse(() => []);

      expect(
      resultList,
      [testWatchlistTv]);
    });
  });
}