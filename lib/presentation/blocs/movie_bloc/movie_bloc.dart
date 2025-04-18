import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omdb_movie_app/domain/usecases/add_favorite_movie.dart';
import 'package:omdb_movie_app/domain/usecases/remove_favorite_movie.dart';

import '../../../domain/usecases/get_movie_details.dart';
import '../../../domain/usecases/search_movies.dart';
import 'movie_event.dart';
import 'movie_state.dart';

/// Bloc for managing movie-related states and events.
/// Handles user interactions for searching movies and fetching movie details.
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  // Use case for searching movies based on a query.
  final SearchMovies searchMovies;

  // Use case for fetching detailed information about a specific movie.
  final GetMovieDetails getMovieDetails;

  // Use case for adding a movie to the favorites list.
  final AddFavoriteMovie addFavoriteMovie;

  // Use case for removing a movie from the favorites list.
  final RemoveFavoriteMovie removeFavoriteMovie;

  /// Constructor for initializing the `MovieBloc` with required dependencies.
  /// The `super` call sets the initial state to `MovieInitial`.
  MovieBloc({
    required this.searchMovies,
    required this.getMovieDetails,
    required this.addFavoriteMovie,
    required this.removeFavoriteMovie,
  }) : super(MovieInitial()) {
    // Event handler for `SearchMoviesEvent`.
    // Triggered when the user initiates a search for movies.
    on<SearchMoviesEvent>((event, emit) async {
      // Emit the `MovieLoading` state to indicate loading in progress.
      emit(MovieLoading());

      // Execute the `searchMovies` use case with the user's query.
      final result = await searchMovies(event.query);

      // Handle the result using the `fold` method:
      // - On failure, emit a `MovieError` state with an error message.
      // - On success, emit a `MoviesLoaded` state with the list of movies.
      result.fold(
        (failure) => emit(MovieError('Failed to load movies.')),
        (movies) => emit(MoviesLoaded(movies)),
      );
    });

    // Event handler for `GetMovieDetailsEvent`.
    // Triggered when the user selects a movie to view its details.
    on<GetMovieDetailsEvent>((event, emit) async {
      // Emit the `MovieLoading` state to indicate loading in progress.
      emit(MovieLoading());

      // Execute the `getMovieDetails` use case with the selected movie ID.
      final result = await getMovieDetails(event.movieId);

      // Handle the result using the `fold` method:
      // - On failure, emit a `MovieError` state with an error message.
      // - On success, emit a `MovieDetailsLoaded` state with the movie details.
      result.fold(
        (failure) => emit(MovieError('Failed to load movie details.')),
        (details) => emit(MovieDetailsLoaded(details)),
      );
    });

    // Event handler for `AddFavoriteMovieDetailsEvent`.
    // Triggered when the user selects a movie to add it to their favorites.
    on<AddFavoriteMovieDetailsEvent>((event, emit) async {
      // Execute the `addFavoriteMovie` use case with the selected movie details.
      final result = await addFavoriteMovie(event.movieDetails);

      // Handle the result using the `fold` method:
      // - On failure, emit a `MovieError` state with an error message.
      // - On success, emit a `MovieDetailsLoaded` state with the movie details.
      // Note: The `isFavorite` property is set to true to indicate the movie is now a favorite.
      result.fold(
        (failure) => emit(MovieError('Failed to add movie to favorites.')),
        (success) => emit(
          MovieDetailsLoaded(event.movieDetails.copyWith(isFavorite: true)),
        ),
      );
    });

    // Event handler for `RemoveFavoriteMovieDetailsEvent`.
    // Triggered when the user selects a movie to remove it from their favorites.
    on<RemoveFavoriteMovieDetailsEvent>((event, emit) async {
      // Execute the `removeFavoriteMovie` use case with the selected movie ID.
      final result = await removeFavoriteMovie(event.movieDetails.imdbID);

      // Handle the result using the `fold` method:
      // - On failure, emit a `MovieError` state with an error message.
      // - On success, emit a `MovieDetailsLoaded` state with the movie details.
      // Note: The `isFavorite` property is set to false to indicate the movie is no longer a favorite.
      result.fold(
        (failure) => emit(MovieError('Failed to remove movie from favorites.')),
        (success) => emit(
          MovieDetailsLoaded(event.movieDetails.copyWith(isFavorite: false)),
        ),
      );
    });
  }
}
