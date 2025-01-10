import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:omdb_movie_app/domain/entities/movie.dart';
import 'package:omdb_movie_app/domain/repositories/movie_repository.dart';
import 'package:omdb_movie_app/domain/usecases/search_movies.dart';

import 'search_movies_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  late MockMovieRepository mockMovieRepository;
  late SearchMovies searchMovies;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    searchMovies = SearchMovies(mockMovieRepository);
  });

  test('should get a list of movies from the repository', () async {
    final tMovies = [
      Movie(
          title: 'Inception', year: '2010', imdbID: 'tt1375666', poster: 'N/A'),
    ];

    when(mockMovieRepository.searchMovies(any))
        .thenAnswer((_) async => Right(tMovies));

    final result = await searchMovies('Inception');

    expect(result, Right(tMovies));
    verify(mockMovieRepository.searchMovies('Inception'));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
