import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

  class MockPopularMoviesBloc extends MockBloc<
        PopularsMoviesEvent, PopularsMoviesState> implements PopularsMoviesBloc{}
  class PopularMoviesEventFake extends Fake implements PopularsMoviesEvent{}
  class PopularMoviesStateFake extends Fake implements PopularsMoviesState {}

  @GenerateMocks([PopularsMoviesBloc])
  void main() {
    late MockPopularMoviesBloc mockPopularMoviesBloc;

    setUp(() {
      mockPopularMoviesBloc = MockPopularMoviesBloc();
    });
    setUpAll(() {
      registerFallbackValue(PopularMoviesEventFake());
      registerFallbackValue(PopularMoviesStateFake());
    });

    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<PopularsMoviesBloc>.value(
        value: mockPopularMoviesBloc,
        child: MaterialApp(home: body,
        ),
      );
    }

    testWidgets('Page ought to show center advance bar when stacking',
        (WidgetTester tester) async {

      when(() => mockPopularMoviesBloc.state).thenReturn(PopularsMoviesLoading());
        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);
        await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page ought to show ListView when information is stacked',
        (WidgetTester tester) async {

      when(() => mockPopularMoviesBloc.state).thenReturn(PopularsMoviesLoaded(testMovieList));
        final listViewFinder = find.byType(ListView);
        await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page ought to show content with message when Blunder',
        (WidgetTester tester) async {

      when(() => mockPopularMoviesBloc.state).thenReturn(PopularsMoviesError('error_message'));
        final textFinder = find.byKey(const Key('error_message'));
        await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

      expect(textFinder, findsOneWidget);
    });
}