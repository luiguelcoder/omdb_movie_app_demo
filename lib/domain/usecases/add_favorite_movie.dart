import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/movie_details.dart';
import '../repositories/movie_repository.dart';

/// Use case to add a movie to the favorites list.
class AddFavoriteMovie implements UseCase<bool, MovieDetails> {
  final MovieRepository repository;

  AddFavoriteMovie(this.repository);

  /// Executes the use case by delegating to the repository.
  @override
  Future<Either<Failure, bool>> call(MovieDetails movieDetails) async {
    return await repository.addFavoriteMovie(movieDetails);
  }
}
