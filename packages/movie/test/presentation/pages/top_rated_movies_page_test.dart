import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

  class MockTopRatedMoviesBloc extends MockBloc<
        TopRatedsMoviesEvent, TopRatedsMoviesState> implements TopRatedsMoviesBloc{}
  class TopRatedsMoviesEventFake extends Fake implements TopRatedsMoviesEvent{}
  class TopRatedsMoviesStateFake extends Fake implements TopRatedsMoviesState {}

  @GenerateMocks([TopRatedsMoviesBloc])
  void main() {
    late MockTopRatedMoviesBloc mockTopRatedsMoviesBloc;

    setUp(() {
      mockTopRatedsMoviesBloc = MockTopRatedMoviesBloc();
    });
    setUpAll(() {
      registerFallbackValue(TopRatedsMoviesEventFake());
      registerFallbackValue(TopRatedsMoviesStateFake());
    });

    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<TopRatedsMoviesBloc>.value(
        value: mockTopRatedsMoviesBloc,
        child: MaterialApp(home: body,
        ),
      );
    }

    testWidgets('Page ought to show center advance bar when stacking',
        (WidgetTester tester) async {

      when(() => mockTopRatedsMoviesBloc.state).thenReturn(TopRatedsMoviesLoading());
        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);
        await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page ought to show ListView when information is stacked',
        (WidgetTester tester) async {

      when(() => mockTopRatedsMoviesBloc.state).thenReturn(TopRatedsMoviesLoaded(testMovieList));
        final listViewFinder = find.byType(ListView);
        await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page ought to show content with message when Blunder',
        (WidgetTester tester) async {

      when(() => mockTopRatedsMoviesBloc.state).thenReturn(TopRatedsMoviesError('error_message'));
        final textFinder = find.byKey(const Key('error_message'));
        await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

      expect(textFinder, findsOneWidget);
    });
}