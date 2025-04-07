import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_details.dart';

/// Base class for all states in the MovieBloc.
/// Extends `Equatable` to allow for efficient state comparison and re-rendering
/// only when the state changes.
abstract class MovieState extends Equatable {
  /// Override the `props` property to specify which fields are considered
  /// for equality comparison. By default, it returns an empty list.
  @override
  List<Object?> get props => [];
}

/// Initial state of the MovieBloc.
/// Represents the state when no action has been taken yet.
class MovieInitial extends MovieState {}

/// State emitted when a loading process is underway.
/// For example, when movies are being searched or details are being fetched.
class MovieLoading extends MovieState {}

/// State emitted when a list of movies is successfully loaded.
/// Holds a `movies` field that contains the list of fetched `Movie` entities.
class MoviesLoaded extends MovieState {
  // List of movies fetched based on the user's search query.
  final List<Movie> movies;

  /// Constructor to initialize the state with a list of movies.
  MoviesLoaded(this.movies);

  /// Override the `props` property to include the `movies` field,
  /// ensuring equality is based on the content of the list.
  @override
  List<Object?> get props => [movies];
}

/// State emitted when detailed information about a specific movie is successfully loaded.
/// Holds a `movieDetails` field containing the fetched `MovieDetails` entity.
class MovieDetailsLoaded extends MovieState {
  // Detailed information about the selected movie.
  final MovieDetails movieDetails;

  /// Constructor to initialize the state with the movie details.
  MovieDetailsLoaded(this.movieDetails);

  /// Override the `props` property to include the `movieDetails` field,
  /// ensuring equality is based on the content of the details.
  @override
  List<Object?> get props => [movieDetails];
}

/// State emitted when an error occurs during any movie-related process.
/// Holds a `message` field that contains the error description.
class MovieError extends MovieState {
  // Error message describing the issue encountered.
  final String message;

  /// Constructor to initialize the state with an error message.
  MovieError(this.message);

  /// Override the `props` property to include the `message` field,
  /// ensuring equality is based on the content of the message.
  @override
  List<Object?> get props => [message];
}
