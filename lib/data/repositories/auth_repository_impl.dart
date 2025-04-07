import 'package:dartz/dartz.dart';
import 'package:omdb_movie_app/core/error/failures.dart';
import 'package:omdb_movie_app/data/datasources/auth_local_data_source.dart';
import 'package:omdb_movie_app/domain/entities/user.dart';
import 'package:omdb_movie_app/domain/repositories/auth_repository.dart';

/// Implementation of the AuthRepository interface.
/// Communicates with the local data source and maps data to domain entities.
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImpl({required this.authLocalDataSource});

  /// SignIn method to handle user sign-in.
  @override
  Future<Either<Failure, User>> signIn(String email, password) async {
    try {
      final userModel = await authLocalDataSource.signIn(email, password);
      final user = User(
        id: userModel.id,
        name: userModel.name,
        email: userModel.email,
      );
      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
