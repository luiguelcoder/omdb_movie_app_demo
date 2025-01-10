import 'package:dartz/dartz.dart';
import 'package:omdb_movie_app/core/error/failures.dart';

/// Abstract class for use cases.
/// Each use case implements this class with specific input and output types.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
