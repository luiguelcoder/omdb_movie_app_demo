import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/movie_bloc/movie_bloc.dart';
import '../blocs/movie_bloc/movie_event.dart';
import '../blocs/movie_bloc/movie_state.dart';
import 'details_page.dart';

/// Page for searching movies.
/// Allows the user to input a query and displays a list of movies.
class SearchPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Column(
        children: [
          /// Input field for movie search query.
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for a movie',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    context
                        .read<MovieBloc>()
                        .add(SearchMoviesEvent(_searchController.text));
                  },
                ),
              ),
              onSubmitted: (query) {
                context.read<MovieBloc>().add(SearchMoviesEvent(query));
              },
            ),
          ),

          /// Displays a list of movies or error/loading messages.
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MoviesLoaded) {
                  return ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      return ListTile(
                        leading: Image.network(
                          movie.poster,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.broken_image),
                        ),
                        title: Text(movie.title),
                        subtitle: Text(movie.year),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: context.read<MovieBloc>(),
                                child: DetailsPage(movieId: movie.imdbID),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is MovieError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Search for movies to display here.'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
