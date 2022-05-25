import 'package:core/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  const TvDetail({
      required this.backdropPath,
      required this.originalName,
      required this.overview,
      required this.posterPath,
      required this.firstAirDate,
      required this.name,
      required this.id,
      required this.voteCount,
      required this.genres,
      required this.voteAverage,
  });

    final String? backdropPath;
    final String originalName;
    final String overview;
    final String posterPath;
    final String firstAirDate;
    final String name;
    final int id;
    final int voteCount;
    final List<Genre> genres;
    final double voteAverage;

  @override
  List<Object?> get props => [
      backdropPath,
      genres,
      id,
      originalName,
      overview,
      posterPath,
      firstAirDate,
      name,
      voteAverage,
      voteCount,
      ];
}
