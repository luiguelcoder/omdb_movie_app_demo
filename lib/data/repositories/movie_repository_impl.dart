import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';

/// Implementation of the MovieRepository interface.
/// Communicates with the remote data source and maps data to domain entities.
class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  /// Searches for movies and maps MovieModel data to Movie entities.
  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    try {
      final movieModels = await remoteDataSource.searchMovies(query);
      final movies = movieModels
          .map((model) => Movie(
                title: model.title,
                year: model.year,
                imdbID: model.imdbID,
                poster: model.poster,
              ))
          .toList();
      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /// Fetches detailed movie information and maps MovieDetailsModel to MovieDetails.
  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(String movieId) async {
    try {
      final detailsModel = await remoteDataSource.fetchMovieDetails(movieId);
      final details = MovieDetails(
        title: detailsModel.title,
        year: detailsModel.year,
        director: detailsModel.director,
        actors: detailsModel.actors,
        plot: detailsModel.plot,
        runtime: detailsModel.runtime,
        genre: detailsModel.genre,
        poster: detailsModel.poster,
      );
      return Right(details);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
