import 'package:equatable/equatable.dart';

import 'package:core/domain/entities/genre.dart';

class MovieDetail extends Equatable {
  const MovieDetail({
    required this.backdropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.runtime,
    required this.id,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
    required this.adult,
  });

    final String? backdropPath;
    final String originalTitle;
    final String overview;
    final String posterPath;
    final String releaseDate;
    final String title;
    final int runtime;
    final int id;
    final int voteCount;
    final double voteAverage;
    final List<Genre> genres;
    final bool adult;

  @override
  List<Object?> get props => [
          adult,
          backdropPath,
          genres,
          id,
          originalTitle,
          overview,
          posterPath,
          releaseDate,
          title,
          voteAverage,
          voteCount,
      ];
}
