// Mocks generated by Mockito 5.2.0 from annotations
// in movie/test/presentation/pages/top_rated_movies_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:flutter_bloc/flutter_bloc.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/domain/usecases/get_top_rated_movies.dart' as _i2;
import 'package:movie/presentation/bloc/toprated_movie/toprated_movie_bloc.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetTopRatedMovies_0 extends _i1.Fake
    implements _i2.GetTopRatedMovies {}

class _FakeTopRatedsMoviesState_1 extends _i1.Fake
    implements _i3.TopRatedsMoviesState {}

/// A class which mocks [TopRatedsMoviesBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockTopRatedsMoviesBloc extends _i1.Mock
    implements _i3.TopRatedsMoviesBloc {
  MockTopRatedsMoviesBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTopRatedMovies get getTopRatedMovies =>
      (super.noSuchMethod(Invocation.getter(#getTopRatedMovies),
          returnValue: _FakeGetTopRatedMovies_0()) as _i2.GetTopRatedMovies);
  @override
  _i3.TopRatedsMoviesState get state => (super.noSuchMethod(
      Invocation.getter(#state),
      returnValue: _FakeTopRatedsMoviesState_1()) as _i3.TopRatedsMoviesState);
  @override
  _i4.Stream<_i3.TopRatedsMoviesState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i3.TopRatedsMoviesState>.empty())
          as _i4.Stream<_i3.TopRatedsMoviesState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i3.TopRatedsMoviesEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i3.TopRatedsMoviesEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i3.TopRatedsMoviesState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i3.TopRatedsMoviesEvent>(
          _i5.EventHandler<E, _i3.TopRatedsMoviesState>? handler,
          {_i5.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i5.Transition<_i3.TopRatedsMoviesEvent, _i3.TopRatedsMoviesState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  void onChange(_i5.Change<_i3.TopRatedsMoviesState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
}
