import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_local_data_source.dart';
import '../datasources/movie_remote_data_source.dart';
import '../models/movie_details_model.dart';

/// Implementation of the MovieRepository interface.
/// Communicates with the remote data source and maps data to domain entities.
class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  /// Searches for movies and maps MovieModel data to Movie entities.
  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    try {
      final movieModels = await remoteDataSource.searchMovies(query);
      final favoriteMovies = await localDataSource.getFavoriteMovieIds();
      final movies = movieModels
          .map((model) => Movie(
                title: model.title,
                year: model.year,
                imdbID: model.imdbID,
                poster: model.poster,
                isFavorite: favoriteMovies.contains(model.imdbID),
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
      final isFavorite = await localDataSource.isFavoriteMovie(movieId);

      final details = MovieDetails(
        imdbID: detailsModel.imdbID,
        title: detailsModel.title,
        year: detailsModel.year,
        director: detailsModel.director,
        actors: detailsModel.actors,
        plot: detailsModel.plot,
        runtime: detailsModel.runtime,
        genre: detailsModel.genre,
        poster: detailsModel.poster,
        isFavorite: isFavorite,
      );
      return Right(details);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addFavoriteMovie(
    MovieDetails movieDetails,
  ) async {
    try {
      final movieDetailsModel = MovieDetailsModel.fromMovieDetails(
        movieDetails,
      );
      await localDataSource.addFavoriteMovie(movieDetailsModel);

      return const Right(true);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> removeFavoriteMovie(String movieId) async {
    try {
      await localDataSource.removeFavoriteMovie(movieId);

      return const Right(true);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
