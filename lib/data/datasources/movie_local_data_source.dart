// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';

import '../models/movie_details_model.dart';

/// Interface for fetching movie data from a local DB.
abstract class MovieLocalDataSource {
  /// Returns a list of favorite movie IDs.
  Future<List<String>> getFavoriteMovieIds();

  /// Adds a movie to the favorites list.
  Future<bool> addFavoriteMovie(MovieDetailsModel moviedetailsModel);

  /// Removes a movie from the favorites list.
  Future<bool> removeFavoriteMovie(String movieId);

  /// Checks if a movie is in the favorites list.
  Future<bool> isFavoriteMovie(String movieId);
}

/// Implementation of MovieLocalDataSource using the OMDb API.
class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final HiveInterface localDataBase;
  static const favoriteMoviesBoxName = 'favoriteMovies';

  MovieLocalDataSourceImpl({required this.localDataBase});

  Future<Box> _getFavoriteMoviesBox() async {
    /// This will open a box with the name favoriteMoviesBoxName.
    return await localDataBase.openBox<Map<String, dynamic>>(
      favoriteMoviesBoxName,
    );
  }

  @override
  Future<List<String>> getFavoriteMovieIds() async {
    final box = await _getFavoriteMoviesBox();

    /// This will return the IDs of the movies of the box as a list of strings.
    final List<String> movieIds = [];

    // Iterate over all keys in the box
    for (var key in box.keys) {
      // Add the movie's IMDb ID to the list (assuming key is the IMDb ID)
      movieIds.add(key);
    }

    return movieIds;
  }

  @override
  Future<bool> addFavoriteMovie(MovieDetailsModel moviedetailsModel) async {
    try {
      final box = await _getFavoriteMoviesBox();
      await box.put(moviedetailsModel.imdbID, moviedetailsModel.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> removeFavoriteMovie(String movieId) async {
    try {
      final box = await _getFavoriteMoviesBox();
      await box.delete(movieId);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> isFavoriteMovie(String movieId) async {
    try {
      final box = await _getFavoriteMoviesBox();
      return box.containsKey(movieId);
    } catch (_) {
      return false;
    }
  }
}
