import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/movie.dart';
import '../entities/movie_details.dart';

/// Abstract repository interface for movies.
/// Defines methods to search for movies and fetch movie details.
abstract class MovieRepository {
  /// Searches for movies based on a query string.
  Future<Either<Failure, List<Movie>>> searchMovies(String query);

  /// Fetches detailed information about a movie by its ID.
  Future<Either<Failure, MovieDetails>> getMovieDetails(String movieId);

  /// Adds a movie to the favorites list.
  /// Returns the updated movie details.
  Future<Either<Failure, bool>> addFavoriteMovie(
    MovieDetails movieDetails,
  );

  /// Removes a movie from the favorites list by its ID.
  Future<Either<Failure, bool>> removeFavoriteMovie(String movieId);
}
