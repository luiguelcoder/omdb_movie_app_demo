import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:omdb_movie_app/data/datasources/auth_local_data_source.dart';
import 'package:omdb_movie_app/data/repositories/auth_repository_impl.dart';
import 'package:omdb_movie_app/domain/usecases/add_favorite_movie.dart';
import 'package:omdb_movie_app/domain/usecases/remove_favorite_movie.dart';
import 'package:omdb_movie_app/domain/usecases/sign_in_user.dart';
import 'package:omdb_movie_app/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:omdb_movie_app/presentation/pages/sign_in_page.dart';

import 'data/datasources/movie_local_data_source.dart';
import 'data/datasources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/usecases/get_movie_details.dart';
import 'domain/usecases/search_movies.dart';
import 'presentation/blocs/movie_bloc/movie_bloc.dart';
import 'presentation/pages/search_page.dart';

// Entry point of the Flutter application.
void main() async {
  // Ensure that plugin services are initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Init Hive for local data storage.
  await Hive.initFlutter();

  // Calls the root widget of the application.
  runApp(const MyApp());
}

// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency Injection:
    // - Initialize an HTTP client to handle API requests.
    final http.Client client = http.Client();

    // - Create an instance of the local data source, which handles user authentication.
    const authLocalDataSource = AuthLocalDataSourceImpl();

    // - Create an instance of the remote data source, which interacts with the OMDb API.
    final movieRemoteDataSource = MovieRemoteDataSourceImpl(client: client);

    // - Create an instance of the local data source, which handles movie data storage.
    final movieLocalDataSource = MovieLocalDataSourceImpl(localDataBase: Hive);

    // - Create an instance of the auth repository, which abstracts data operations
    //   and provides a single source of truth for the app.
    final authRepository = AuthRepositoryImpl(
      authLocalDataSource: authLocalDataSource,
    );

    // - Create an instance of the repository, which abstracts data operations
    //   and provides a single source of truth for the app.
    final movieRepository = MovieRepositoryImpl(
      remoteDataSource: movieRemoteDataSource,
      localDataSource: movieLocalDataSource,
    );

    // - Initialize use cases for searching movies and fetching movie details.
    final signInUser = SignInUser(authRepository);
    final searchMovies = SearchMovies(movieRepository);
    final getMovieDetails = GetMovieDetails(movieRepository);
    final addFavoriteMovie = AddFavoriteMovie(movieRepository);
    final removeFavoriteMovie = RemoveFavoriteMovie(movieRepository);

    // The `MultiBlocProvider` is used to provide multiple BLoCs to the widget tree.
    return MultiBlocProvider(
      providers: [
        // Create the `AuthBloc` and inject the required use cases for state management.
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(signInUser: signInUser),
        ),
        // Create the `MovieBloc` and inject the required use cases for state management.
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc(
            searchMovies: searchMovies,
            getMovieDetails: getMovieDetails,
            addFavoriteMovie: addFavoriteMovie,
            removeFavoriteMovie: removeFavoriteMovie,
          ),
        ),
      ],

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
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            // Check the current state of the authentication process.
            if (state is AuthSucess) {
              // If the user is authenticated, navigate to the `SearchPage`.
              return SearchPage();
            } else {
              return const SignInPage();
            }
          },
        ),
      ),
    );
  }
}
