import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/movie_repository.dart';

/// Use case to add a movie to the favorites list.
class RemoveFavoriteMovie implements UseCase<bool, String> {
  final MovieRepository repository;

  RemoveFavoriteMovie(this.repository);

  /// Executes the use case by delegating to the repository.
  @override
  Future<Either<Failure, bool>> call(String movieId) async {
    return await repository.removeFavoriteMovie(movieId);
  }
}
