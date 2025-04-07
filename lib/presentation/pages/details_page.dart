import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/movie_bloc/movie_bloc.dart';
import '../blocs/movie_bloc/movie_event.dart';
import '../blocs/movie_bloc/movie_state.dart';

/// Page displaying detailed information about a selected movie.
class DetailsPage extends StatelessWidget {
  final String movieId;

  DetailsPage({required this.movieId});

  @override
  Widget build(BuildContext context) {
    // Fetch movie details when the page is built.
    context.read<MovieBloc>().add(GetMovieDetailsEvent(movieId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailsLoaded) {
            final details = state.movieDetails;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    details.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Year: ${details.year}', style: TextStyle(fontSize: 16)),
                  Text('Director: ${details.director}',
                      style: TextStyle(fontSize: 16)),
                  Text('Actors: ${details.actors}',
                      style: TextStyle(fontSize: 16)),
                  Text('Runtime: ${details.runtime}',
                      style: TextStyle(fontSize: 16)),
                  Text('Genre: ${details.genre}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Text(
                    'Plot',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(details.plot, style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          } else if (state is MovieError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message, style: TextStyle(color: Colors.red)),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<MovieBloc>()
                          .add(GetMovieDetailsEvent(movieId));
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Unexpected error occurred.'));
          }
        },
      ),
    );
  }
}
