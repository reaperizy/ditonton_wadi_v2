import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/usecases/get_tv_recommendations.dart';

import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvRecommendations(mockTvRepository);
  });

  const tId = 1;
  final tTv = <Tv>[];

  test('should get list of tv recommendations from the repository', () async {

    // arrange
    when(mockTvRepository.getTvRecommendations(tId)).thenAnswer((_) async => Right(tTv));

    // act
    final result = await usecase.execute(tId);

    // assert
    expect(
      result,
      Right(tTv));
  });
}
