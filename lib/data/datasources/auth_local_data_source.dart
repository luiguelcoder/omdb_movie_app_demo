import 'package:omdb_movie_app/data/models/user_model.dart';

/// Interface for fetching movie data from a remote API.
abstract class AuthLocalDataSource {
  /// Searches for movies based on a query string.
  Future<UserModel> signIn(String email, String password);
}

/// Implementation of AuthLocalDataSource
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl();

  @override
  Future<UserModel> signIn(String email, String password) async {
    /// Simulate a network delay
    await Future.delayed(
      const Duration(seconds: 2),
    );

    /// We are going to return a hardcoded user model for now.
    return const UserModel(
      id: 'test',
      name: 'Test User',
      email: 'test@test.com',
    );
  }
}
