import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

/// Use case to search for movies by a query string.
class SearchMovies implements UseCase<List<Movie>, String> {
  final MovieRepository repository;

  SearchMovies(this.repository);

  /// Executes the use case by delegating to the repository.
  @override
  Future<Either<Failure, List<Movie>>> call(String query) async {
    return await repository.searchMovies(query);
  }
}
