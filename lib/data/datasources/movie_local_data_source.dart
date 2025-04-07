/// Interface for fetching movie data from a local DB.
abstract class MovieLocalDataSource {
  /// Returns a list of favorite movie IDs.
  Future<List<String>> fetchFavoriteMovieIds(String userId);

  /// Adds a movie to the favorites list.
  Future<bool> addFavoriteMovie(String userId, String movieId);

  /// Removes a movie from the favorites list.
  Future<bool> removeFavoriteMovie(String userId, String movieId);
}

/// Implementation of MovieLocalDataSource using the OMDb API.
class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  @override
  Future<bool> addFavoriteMovie(String userId, String movieId) {
    // TODO: implement addFavoriteMovie
    throw UnimplementedError();
  }

  @override
  Future<List<String>> fetchFavoriteMovieIds(String userId) {
    // TODO: implement fetchFavoriteMovieIds
    throw UnimplementedError();
  }

  @override
  Future<bool> removeFavoriteMovie(String userId, String movieId) {
    // TODO: implement removeFavoriteMovie
    throw UnimplementedError();
  }
}
