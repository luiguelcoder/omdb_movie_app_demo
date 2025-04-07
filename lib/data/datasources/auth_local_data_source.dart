import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:omdb_movie_app/data/models/user_model.dart';

/// Interface for fetching movie data from a remote API.
abstract class AuthLocalDataSource {
  /// Searches for movies based on a query string.
  Future<UserModel> signIn(String email, String password);
}

/// Implementation of AuthLocalDataSource using the FlutterSecureStorage package.
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<UserModel> signIn(String email, String password) async {
    /// Simulate a network delay
    await Future.delayed(
      const Duration(seconds: 3),
    );

    /// We are going to return a hardcoded user model for now.
    return const UserModel(
      id: 'test',
      name: 'Test User',
      email: 'test@test.com',
    );
  }
}
