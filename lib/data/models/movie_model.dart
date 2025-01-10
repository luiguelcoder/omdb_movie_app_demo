import '../../domain/entities/movie.dart';

/// Model representing a movie fetched from the OMDb API.
/// Extends the core Movie entity and includes JSON parsing methods.
class MovieModel extends Movie {
  MovieModel({
    required String title,
    required String year,
    required String imdbID,
    required String poster,
  }) : super(title: title, year: year, imdbID: imdbID, poster: poster);

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
