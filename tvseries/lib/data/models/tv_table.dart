import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/entities/tv_detail.dart';

class TvTable extends Equatable {
  final String? name;
  final String? posterPath;
  final String? overview;
  final int id;

  const TvTable({
    required this.name,
    required this.posterPath,
    required this.overview,
    required this.id,
  });

  factory TvTable.fromEntity(TvDetail tv) =>
    TvTable(
        name: tv.name,
        posterPath: tv.posterPath,
        overview: tv.overview,
        id: tv.id,
      );

  factory TvTable.fromMap(Map<String, dynamic> map) =>
    TvTable(
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        id: map['id'],
      );

  Map<String, dynamic>
    toJson() => {
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
        'id': id,
      };

  Tv toEntity() =>
    Tv.watchlist(
        overview: overview,
        posterPath: posterPath,
        name: name,
        id: id,
      );

  @override
  List<Object?> get props => [
    name,
    posterPath,
    overview,
    id];
}
