// Mocks generated by Mockito 5.2.0 from annotations
// in tvseries/test/presentation/bloc/watchlist_tv_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i9;

import 'package:core/utils/failure.dart' as _i11;
import 'package:dartz/dartz.dart' as _i7;
import 'package:flutter_bloc/flutter_bloc.dart' as _i10;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tvseries/domain/entities/tv.dart' as _i12;
import 'package:tvseries/domain/entities/tv_detail.dart' as _i13;
import 'package:tvseries/domain/repositories/tv_repository.dart' as _i8;
import 'package:tvseries/domain/usecases/get_watchlist_status_tv.dart' as _i5;
import 'package:tvseries/domain/usecases/get_watchlist_tv.dart' as _i4;
import 'package:tvseries/domain/usecases/remove_watchlist_tv.dart' as _i3;
import 'package:tvseries/domain/usecases/save_watchlist_tv.dart' as _i2;
import 'package:tvseries/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart'
    as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeSaveWatchlistTv_0 extends _i1.Fake implements _i2.SaveWatchlistTv {}

class _FakeRemoveWatchlistTv_1 extends _i1.Fake
    implements _i3.RemoveWatchlistTv {}

class _FakeGetWatchlistTv_2 extends _i1.Fake implements _i4.GetWatchlistTv {}

class _FakeGetWatchListStatusTv_3 extends _i1.Fake
    implements _i5.GetWatchListStatusTv {}

class _FakeWatchlistTvsState_4 extends _i1.Fake
    implements _i6.WatchlistTvsState {}

class _FakeEither_5<L, R> extends _i1.Fake implements _i7.Either<L, R> {}

class _FakeTvRepository_6 extends _i1.Fake implements _i8.TvRepository {}

/// A class which mocks [WatchlistTvsBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistTvsBloc extends _i1.Mock implements _i6.WatchlistTvsBloc {
  MockWatchlistTvsBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SaveWatchlistTv get saveWatchlist =>
      (super.noSuchMethod(Invocation.getter(#saveWatchlist),
          returnValue: _FakeSaveWatchlistTv_0()) as _i2.SaveWatchlistTv);
  @override
  _i3.RemoveWatchlistTv get removeWatchlist =>
      (super.noSuchMethod(Invocation.getter(#removeWatchlist),
          returnValue: _FakeRemoveWatchlistTv_1()) as _i3.RemoveWatchlistTv);
  @override
  _i4.GetWatchlistTv get getWatchlistTv =>
      (super.noSuchMethod(Invocation.getter(#getWatchlistTv),
          returnValue: _FakeGetWatchlistTv_2()) as _i4.GetWatchlistTv);
  @override
  _i5.GetWatchListStatusTv get getWatchListStatus => (super.noSuchMethod(
      Invocation.getter(#getWatchListStatus),
      returnValue: _FakeGetWatchListStatusTv_3()) as _i5.GetWatchListStatusTv);
  @override
  _i6.WatchlistTvsState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakeWatchlistTvsState_4()) as _i6.WatchlistTvsState);
  @override
  _i9.Stream<_i6.WatchlistTvsState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i6.WatchlistTvsState>.empty())
          as _i9.Stream<_i6.WatchlistTvsState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i6.WatchlistTvsEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i6.WatchlistTvsEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i6.WatchlistTvsState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i6.WatchlistTvsEvent>(
          _i10.EventHandler<E, _i6.WatchlistTvsState>? handler,
          {_i10.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i10.Transition<_i6.WatchlistTvsEvent, _i6.WatchlistTvsState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i9.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  void onChange(_i10.Change<_i6.WatchlistTvsState>? change) =>
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

/// A class which mocks [GetWatchlistTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistTv extends _i1.Mock implements _i4.GetWatchlistTv {
  MockGetWatchlistTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i7.Either<_i11.Failure, List<_i12.Tv>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i7.Either<_i11.Failure, List<_i12.Tv>>>.value(
              _FakeEither_5<_i11.Failure, List<_i12.Tv>>())) as _i9
          .Future<_i7.Either<_i11.Failure, List<_i12.Tv>>>);
}

/// A class which mocks [GetWatchListStatusTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatusTv extends _i1.Mock
    implements _i5.GetWatchListStatusTv {
  MockGetWatchListStatusTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_6()) as _i8.TvRepository);
  @override
  _i9.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i9.Future<bool>);
}

/// A class which mocks [RemoveWatchlistTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistTv extends _i1.Mock implements _i3.RemoveWatchlistTv {
  MockRemoveWatchlistTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_6()) as _i8.TvRepository);
  @override
  _i9.Future<_i7.Either<_i11.Failure, String>> execute(_i13.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i7.Either<_i11.Failure, String>>.value(
                  _FakeEither_5<_i11.Failure, String>()))
          as _i9.Future<_i7.Either<_i11.Failure, String>>);
}

/// A class which mocks [SaveWatchlistTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistTv extends _i1.Mock implements _i2.SaveWatchlistTv {
  MockSaveWatchlistTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_6()) as _i8.TvRepository);
  @override
  _i9.Future<_i7.Either<_i11.Failure, String>> execute(_i13.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i7.Either<_i11.Failure, String>>.value(
                  _FakeEither_5<_i11.Failure, String>()))
          as _i9.Future<_i7.Either<_i11.Failure, String>>);
}
