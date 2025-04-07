import 'package:dartz/dartz.dart';
import 'package:omdb_movie_app/core/error/failures.dart';
import 'package:omdb_movie_app/core/usecases/usecase.dart';
import 'package:omdb_movie_app/domain/entities/sign_in_params.dart';
import 'package:omdb_movie_app/domain/entities/user.dart';
import 'package:omdb_movie_app/domain/repositories/auth_repository.dart';

/// Use case to sign in a user.
class SignInUser implements UseCase<User, SignInParams> {
  final AuthRepository repository;

  SignInUser(this.repository);

  /// Executes the use case by delegating to the repository.
  @override
  Future<Either<Failure, User>> call(SignInParams signInParams) async {
    return await repository.signIn(signInParams.email, signInParams.password);
  }
}
