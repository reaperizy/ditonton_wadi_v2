import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

class TvModel extends Equatable {
  const TvModel({
      required this.backdropPath,
      required this.posterPath,
      required this.firstAirDate,
      required this.originalName,
      required this.overview,
      required this.name,
      required this.popularity,
      required this.voteAverage,
      required this.voteCount,
      required this.id,
      required this.genreIds,
  });

    final String? backdropPath;
    final String? posterPath;
    final String? firstAirDate;
    final String originalName;
    final String overview;
    final String name;
    final double popularity;
    final double voteAverage;
    final int voteCount;
    final int id;
    final List<int> genreIds;

  factory TvModel.fromJson(Map<String, dynamic> json) =>
    TvModel(
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        firstAirDate: json["first_air_date"],
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic>
     toJson() => {
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date": firstAirDate,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  Tv toEntity() { return
    Tv(
      backdropPath: backdropPath,
      genreIds: genreIds,
      id: id,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      firstAirDate: firstAirDate,
      name: name,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?>
    get props => [
        backdropPath,
        genreIds,
        id,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
      ];
}
