import '../../domain/entities/movie.dart';

/// Model representing a movie fetched from the OMDb API.
/// Extends the core Movie entity and includes JSON parsing methods.
class MovieModel extends Movie {
  const MovieModel({
    required super.title,
    required super.year,
    required super.imdbID,
    required super.poster,
  });

  /// Factory method to create a MovieModel from a JSON map.
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['Title'],
      year: json['Year'],
      imdbID: json['imdbID'],
      poster: json['Poster'],
    );
  }
}
