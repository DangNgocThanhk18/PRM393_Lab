import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';
import '../providers/movie_providers.dart';

class MovieDetailScreen extends ConsumerWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trailers = ref.watch(trailerListProvider(movie.title));
    final toggleTrailer = ref.read(trailerToggleProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Title
          Text(
            movie.title,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Genres
          ...movie.genres.map((genre) => Text(genre)),
          const SizedBox(height: 8),

          // Overview
          Text(movie.overview),
          const SizedBox(height: 16),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text('Favorite'),
              Text('Rate'),
              Text('Share'),
            ],
          ),
          const SizedBox(height: 16),

          // Trailers section
          const Text(
            'Trailers',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Trailers list
          ...trailers.asMap().entries.map((entry) {
            final index = entry.key;
            final trailer = entry.value;
            return ListTile(
              leading: Icon(
                trailer.isWatched ? Icons.check_box : Icons.check_box_outline_blank,
              ),
              title: Text(trailer.title),
              onTap: () => toggleTrailer(movie.title, index),
            );
          }),
        ],
      ),
    );
  }
}