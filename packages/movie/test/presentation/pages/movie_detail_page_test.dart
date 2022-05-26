import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<
      DetailsMoviesEvent, DetailsMoviesState> implements DetailsMoviesBloc{}
class FakeDetailsMovieEvent extends Fake implements DetailsMoviesEvent{}
class FakeDetailsMoviesState extends Fake implements DetailsMoviesState{}

class MockWatchlistMoviesBloc extends MockBloc<
      WatchlistMoviesEvent, WatchlistMoviesState> implements WatchlistMoviesBloc{}
class FakeWatchlistMoviesEvent extends Fake implements WatchlistMoviesEvent{}
class FakeWatchlistMoviesState extends Fake implements WatchlistMoviesState{}

class MockRecommendMoviesBloc extends MockBloc<
      RecommendMoviesEvent, RecommendMoviesState> implements RecommendMoviesBloc{}
class FakeRecommendMoviesEvent extends Fake implements RecommendMoviesEvent{}
class FakeRecommendMoviesState extends Fake implements RecommendMoviesState{}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockWatchlistMoviesBloc mockWatchlistMoviesBloc;
  late MockRecommendMoviesBloc mockMovieRecommendationBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();
    mockMovieRecommendationBloc = MockRecommendMoviesBloc();
  });
  setUpAll(() {
    registerFallbackValue(FakeDetailsMoviesState());
    registerFallbackValue(FakeDetailsMovieEvent());

    registerFallbackValue(FakeWatchlistMoviesEvent());
    registerFallbackValue(FakeWatchlistMoviesState());

    registerFallbackValue(FakeRecommendMoviesEvent());
    registerFallbackValue(FakeRecommendMoviesState());
  });
  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailsMoviesBloc>(create: (_) => mockMovieDetailBloc),
        BlocProvider<WatchlistMoviesBloc>(create: (_) => mockWatchlistMoviesBloc),
        BlocProvider<RecommendMoviesBloc>(create: (_) => mockMovieRecommendationBloc),
      ],
      child: MaterialApp(
        home: body,
      ));
  }

    testWidgets(
        'Watchlist button ought to show include symbol when motion picture not included to watchlist', (WidgetTester tester) async {
          when(() => mockMovieDetailBloc.state).thenReturn(MoviesDetailsLoaded(testMovieDetail));
          when(() => mockWatchlistMoviesBloc.state).thenReturn(const MovieWatchlistStatusLoaded(false));
          when(() => mockMovieRecommendationBloc.state).thenReturn(RecommendMoviesLoaded(testMovieList));

          final watchlistButtonIcon = find.byIcon(Icons.add);
          await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));
          expect(watchlistButtonIcon, findsOneWidget);
        });

    testWidgets(
        'Watchlist button ought to show check symbol when motion picture is included to watchlist', (WidgetTester tester) async {
              when(() => mockMovieDetailBloc.state).thenReturn(MoviesDetailsLoaded(testMovieDetail));
              when(() => mockMovieRecommendationBloc.state).thenReturn(RecommendMoviesLoaded(testMovieList));
              when(() => mockWatchlistMoviesBloc.state).thenReturn(const MovieWatchlistStatusLoaded(true));

          final watchlistButtonIcon = find.byIcon(Icons.check);
          await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));
          expect(watchlistButtonIcon, findsOneWidget);
        });

    testWidgets(
        'Watchlist button not show SnackBar when include to watchlist fizzled', (WidgetTester tester) async {
              when(() => mockMovieDetailBloc.state).thenReturn(MoviesDetailsLoaded(testMovieDetail));
              when(() => mockMovieRecommendationBloc.state).thenReturn(RecommendMoviesLoaded(testMovieList));
              when(() => mockWatchlistMoviesBloc.state).thenReturn(const MovieWatchlistStatusLoaded(false));

          final watchlistButton = find.byType(ElevatedButton);
          await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));
          await tester.tap(watchlistButton);
          await tester.pump();

          expect(find.byIcon(Icons.add), findsOneWidget);
          expect(find.byIcon(Icons.add), findsOneWidget);
          expect(find.byType(SnackBar), findsNothing);
        });
}