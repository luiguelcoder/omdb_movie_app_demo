import 'package:dartz/dartz.dart';
import 'package:omdb_movie_app/domain/entities/user.dart';

import '../../core/error/failures.dart';

/// Abstract repository interface for movies.
/// Defines methods to search for movies and fetch movie details.
abstract class AuthRepository {
  /// Signs up a user with the given email and password.
  Future<Either<Failure, User>> signIn(String email, password);
}
