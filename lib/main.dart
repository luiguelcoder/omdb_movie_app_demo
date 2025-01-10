import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/usecases/get_movie_details.dart';
import 'domain/usecases/search_movies.dart';
import 'presentation/bloc/movie_bloc.dart';
import 'presentation/pages/search_page.dart';

// Entry point of the Flutter application.
void main() {
  // Calls the root widget of the application.
  runApp(MyApp());
}

// The root widget of the application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dependency Injection:
    // - Initialize an HTTP client to handle API requests.
    final http.Client client = http.Client();

    // - Create an instance of the remote data source, which interacts with the OMDb API.
    final movieRemoteDataSource = MovieRemoteDataSourceImpl(client: client);

    // - Create an instance of the repository, which abstracts data operations
    //   and provides a single source of truth for the app.
    final movieRepository =
        MovieRepositoryImpl(remoteDataSource: movieRemoteDataSource);

    // - Initialize use cases for searching movies and fetching movie details.
    final searchMovies = SearchMovies(movieRepository);
    final getMovieDetails = GetMovieDetails(movieRepository);

    // The `BlocProvider` is used to make the `MovieBloc` available to the widget tree.
    return BlocProvider(
      // Create the `MovieBloc` and inject the required use cases for state management.
      create: (_) => MovieBloc(
        searchMovies: searchMovies,
        getMovieDetails: getMovieDetails,
      ),

      // Define the app's structure and configuration.
      child: MaterialApp(
        // Remove the debug banner from the app.
        debugShowCheckedModeBanner: false,

        // Set the title of the application.
        title: 'OMDb Movie Search',

        // Apply a global theme to the app.
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        // Set the initial screen of the app to the `SearchPage`.
        home: SearchPage(),
      ),
    );
  }
}
