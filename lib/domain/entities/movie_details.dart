import 'package:equatable/equatable.dart';

/// Entity representing detailed information about a movie.
/// This is the core representation used in the domain layer.
class MovieDetails extends Equatable {
  final String imdbID;
  final String title;
  final String year;
  final String director;
  final String actors;
  final String plot;
  final String runtime;
  final String genre;
  final String poster;
  final bool isFavorite;

  const MovieDetails({
    required this.imdbID,
    required this.title,
    required this.year,
    required this.director,
    required this.actors,
    required this.plot,
    required this.runtime,
    required this.genre,
    required this.poster,
    this.isFavorite = false,
  });

  MovieDetails copyWith({
    String? imdbID,
    String? title,
    String? year,
    String? director,
    String? actors,
    String? plot,
    String? runtime,
    String? genre,
    String? poster,
    bool? isFavorite,
  }) {
    return MovieDetails(
      imdbID: imdbID ?? this.imdbID,
      title: title ?? this.title,
      year: year ?? this.year,
      director: director ?? this.director,
      actors: actors ?? this.actors,
      plot: plot ?? this.plot,
      runtime: runtime ?? this.runtime,
      genre: genre ?? this.genre,
      poster: poster ?? this.poster,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        imdbID,
        title,
        year,
        director,
        actors,
        plot,
        runtime,
        genre,
        poster,
        isFavorite,
      ];
}
