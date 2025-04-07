import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:omdb_movie_app/core/error/failures.dart';
import 'package:omdb_movie_app/domain/entities/movie.dart';
import 'package:omdb_movie_app/domain/entities/movie_details.dart';
import 'package:omdb_movie_app/domain/usecases/add_favorite_movie.dart';
import 'package:omdb_movie_app/domain/usecases/get_movie_details.dart';
import 'package:omdb_movie_app/domain/usecases/remove_favorite_movie.dart';
import 'package:omdb_movie_app/domain/usecases/search_movies.dart';
import 'package:omdb_movie_app/presentation/blocs/movie_bloc/movie_bloc.dart';
import 'package:omdb_movie_app/presentation/blocs/movie_bloc/movie_event.dart';
import 'package:omdb_movie_app/presentation/blocs/movie_bloc/movie_state.dart';

import 'movie_bloc_test.mocks.dart';

// Generate Mock Classes
@GenerateMocks([
  SearchMovies,
  GetMovieDetails,
  AddFavoriteMovie,
  RemoveFavoriteMovie,
])
void main() {
  late MockSearchMovies mockSearchMovies;
  late MockGetMovieDetails mockGetMovieDetails;
  late MockAddFavoriteMovie mockAddFavoriteMovie;
  late MockRemoveFavoriteMovie mockRemoveFavoriteMovie;
  late MovieBloc movieBloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockGetMovieDetails = MockGetMovieDetails();
    mockAddFavoriteMovie = MockAddFavoriteMovie();
    mockRemoveFavoriteMovie = MockRemoveFavoriteMovie();

    movieBloc = MovieBloc(
      searchMovies: mockSearchMovies,
      getMovieDetails: mockGetMovieDetails,
      addFavoriteMovie: mockAddFavoriteMovie,
      removeFavoriteMovie: mockRemoveFavoriteMovie,
    );
  });

  tearDown(() {
    movieBloc.close();
  });

  group('SearchMoviesEvent', () {
    final tMovieList = [
      const Movie(
        title: 'Inception',
        year: '2010',
        imdbID: 'tt1375666',
        poster: 'N/A',
      ),
    ];

    blocTest<MovieBloc, MovieState>(
      'emits [MovieLoading, MoviesLoaded] when search is successful',
      build: () {
        when(mockSearchMovies(any)).thenAnswer((_) async => Right(tMovieList));
        return movieBloc;
      },
      act: (bloc) => bloc.add(SearchMoviesEvent('Inception')),
      expect: () => [
        MovieLoading(),
        MoviesLoaded(tMovieList),
      ],
    );

    blocTest<MovieBloc, MovieState>(
      'emits [MovieLoading, MovieError] when search fails',
      build: () {
        when(mockSearchMovies(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return movieBloc;
      },
      act: (bloc) => bloc.add(SearchMoviesEvent('Unknown')),
      expect: () => [
        MovieLoading(),
        MovieError('Failed to load movies.'),
      ],
    );
  });

  group('GetMovieDetailsEvent', () {
    const tMovieDetails = MovieDetails(
      imdbID: 'tt1375666',
      title: 'Inception',
      year: '2010',
      director: 'Christopher Nolan',
      actors: 'Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page',
      plot:
          'A thief steals corporate secrets through dream-sharing technology.',
      runtime: '148 min',
      genre: 'Action, Adventure, Sci-Fi',
      poster: 'N/A',
    );

    blocTest<MovieBloc, MovieState>(
      'emits [MovieLoading, MovieDetailsLoaded] when details are fetched successfully',
      build: () {
        when(mockGetMovieDetails(any)).thenAnswer(
          (_) async => const Right(tMovieDetails),
        );
        return movieBloc;
      },
      act: (bloc) => bloc.add(GetMovieDetailsEvent('tt1375666')),
      expect: () => [
        MovieLoading(),
        MovieDetailsLoaded(tMovieDetails),
      ],
    );

    blocTest<MovieBloc, MovieState>(
      'emits [MovieLoading, MovieError] when fetching details fails',
      build: () {
        when(mockGetMovieDetails(any)).thenAnswer(
          (_) async => Left(ServerFailure()),
        );
        return movieBloc;
      },
      act: (bloc) => bloc.add(GetMovieDetailsEvent('InvalidID')),
      expect: () => [
        MovieLoading(),
        MovieError('Failed to load movie details.'),
      ],
    );
  });
}
