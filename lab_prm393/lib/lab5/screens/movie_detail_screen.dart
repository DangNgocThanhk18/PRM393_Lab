import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';
import '../providers/movie_list_viewmodel.dart';

class MovieDetailScreen extends ConsumerWidget {
  final String movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(movieListProvider);

    return moviesAsync.when(
      data: (movies) {
        try {
          final movie = movies.firstWhere((m) => m.id == movieId);
          return _MovieDetailContent(movie: movie);
        } catch (e) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
              backgroundColor: Colors.deepPurple,
            ),
            body: const Center(
              child: Text('Movie not found'),
            ),
          );
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _MovieDetailContent extends ConsumerWidget {
  final Movie movie;

  const _MovieDetailContent({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  movie.posterUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.grey[400],
                      child: const Icon(Icons.movie, size: 80, color: Colors.white54),
                    );
                  },
                ),
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toStringAsFixed(1),
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: movie.genres
                        .map((genre) => Chip(
                      label: Text(genre),
                      backgroundColor: Colors.deepPurple[100],
                    ))
                        .toList(),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Overview',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.overview,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _FavoriteIconButton(movie: movie),
                      _RateIconButton(movie: movie),
                      _ShareIconButton(movie: movie),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildTrailersSection(context, ref),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrailersSection(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trailers',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: movie.trailers.length,
            itemBuilder: (context, index) {
              final trailer = movie.trailers[index];
              return _TrailerItem(
                trailer: trailer,
                movieId: movie.id,
                trailerIndex: index,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FavoriteIconButton extends ConsumerWidget {
  final Movie movie;

  const _FavoriteIconButton({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = movie.isFavorite;
    final color = isFavorite ? Colors.red : Colors.deepPurple;
    final icon = isFavorite ? Icons.favorite : Icons.favorite_border;

    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: color),
          iconSize: 32,
          tooltip: 'Favorite',
          onPressed: () async {
            await ref.read(movieListProvider.notifier).toggleFavorite(movie.id);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(!isFavorite ? 'Added to favorites' : 'Removed from favorites'),
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        const Text('Favorite',style: TextStyle(color: Colors.deepPurple),)
      ],
    );
  }
}
class _RateIconButton extends ConsumerWidget {
  final Movie movie;

  const _RateIconButton({required this.movie});

  void _showRateDialog(BuildContext context, WidgetRef ref) {
    double tempRating = movie.rating;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Rate this movie'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(movie.title),
                const SizedBox(height: 16),
                Slider(
                  value: tempRating,
                  min: 0,
                  max: 10,
                  divisions: 20,
                  label: tempRating.toStringAsFixed(1),
                  onChanged: (value) {
                    setState(() {
                      tempRating = value;
                    });
                  },
                ),
                Text('Your rating: ${tempRating.toStringAsFixed(1)}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  ref.read(movieListProvider.notifier).updateRating(movie.id, tempRating);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Rating saved!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.star, color: Colors.deepPurple),
          iconSize: 32,
          tooltip: 'Rate',
          onPressed: () => _showRateDialog(context, ref),
        ),
        const Text('Rate',style: TextStyle(color: Colors.deepPurple),)
      ],
    );
  }
}
class _ShareIconButton extends ConsumerWidget {
  final Movie movie;

  const _ShareIconButton({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.share, color: Colors.deepPurple),
          iconSize: 32,
          tooltip: 'Share',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Sharing ${movie.title}...'),
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        const Text('Share',style: TextStyle(color: Colors.deepPurple),)
      ],
    );
  }
}
class _TrailerItem extends ConsumerWidget {
  final Trailer trailer;
  final String movieId;
  final int trailerIndex;

  const _TrailerItem({
    required this.trailer,
    required this.movieId,
    required this.trailerIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          trailer.isWatched ? Icons.check_circle : Icons.play_circle,
          color: trailer.isWatched ? Colors.green : Colors.deepPurple,
          size: 30,
        ),
        title: Text(
          trailer.title,
          style: TextStyle(
            fontWeight: trailer.isWatched ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ref.read(movieListProvider.notifier).toggleTrailerWatched(movieId, trailerIndex);
        },
      ),
    );
  }
}