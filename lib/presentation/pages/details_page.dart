import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/movie_bloc/movie_bloc.dart';
import '../blocs/movie_bloc/movie_event.dart';
import '../blocs/movie_bloc/movie_state.dart';

/// Page displaying detailed information about a selected movie.
class DetailsPage extends StatelessWidget {
  final String movieId;

  const DetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    // Fetch movie details when the page is built.
    context.read<MovieBloc>().add(GetMovieDetailsEvent(movieId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailsLoaded) {
            final details = state.movieDetails;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: FadeInImage(
                        placeholder: const AssetImage("assets/camera.jpg"),
                        image: NetworkImage(details.poster),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        details.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          if (details.isFavorite) {
                            context.read<MovieBloc>().add(
                                  RemoveFavoriteMovieDetailsEvent(details),
                                );
                          } else {
                            context.read<MovieBloc>().add(
                                  AddFavoriteMovieDetailsEvent(details),
                                );
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: details.isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Year: ${details.year}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Director: ${details.director}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Actors: ${details.actors}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Runtime: ${details.runtime}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Genre: ${details.genre}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  const Text(
                    'Plot',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(details.plot, style: const TextStyle(fontSize: 16)),
                ],
              ),
            );
          } else if (state is MovieError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message,
                      style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<MovieBloc>()
                          .add(GetMovieDetailsEvent(movieId));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Unexpected error occurred.'));
          }
        },
      ),
    );
  }
}
