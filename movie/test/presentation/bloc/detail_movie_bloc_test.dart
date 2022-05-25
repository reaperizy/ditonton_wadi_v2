import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/presentation/bloc/detailmovie/detail_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main(){
  late DetailsMoviesBloc detailsMoviesBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  const testMovieId = 1;

  setUp((){
    mockGetMovieDetail = MockGetMovieDetail();
    detailsMoviesBloc = DetailsMoviesBloc(mockGetMovieDetail);
  });

  test('the initial state should be MoviesDetailsEmpty', (){
    expect(detailsMoviesBloc.state, MoviesDetailsEmpty());
  });

  blocTest<DetailsMoviesBloc, DetailsMoviesState>('should emit [Loading, Loaded] when GetDetailsMoviesEvent is added',
    build: () {
      when(mockGetMovieDetail.execute(testMovieId)).thenAnswer((_) async => const Right(testMovieDetail));
      return detailsMoviesBloc;
    },
    act: (bloc) {
      bloc.add(GetDetailsMoviesEvent(testMovieId));
    }, expect: () { return [MoviesDetailsLoading(),
      MoviesDetailsLoaded(testMovieDetail)
    ];}, verify: (bloc) {
      verify(mockGetMovieDetail.execute(testMovieId));
      return detailsMoviesBloc.state.props;
    }
  );

  blocTest<DetailsMoviesBloc, DetailsMoviesState>('should emit [Loading, Error] when GetDetailsMoviesEvent is added',
    build: () {
      when(mockGetMovieDetail.execute(testMovieId)).thenAnswer((_) async => const Left(ServerFailure('The Server is Failure')));
      return detailsMoviesBloc;
    },
    act: (bloc) {
      bloc.add(GetDetailsMoviesEvent(testMovieId));
    }, expect: () { return [MoviesDetailsLoading(),
      MoviesDetailsError('The Server is Failure')
    ];}, verify: (bloc) {
      verify(mockGetMovieDetail.execute(testMovieId));
      return detailsMoviesBloc.state.props;
    }
  );
}