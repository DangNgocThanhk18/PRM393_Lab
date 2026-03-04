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
            // Poster với gradient
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
                  // Genres
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

                  // Overview
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
                      _FavoriteButton(movie: movie),
                      _RateButton(movie: movie),
                      _ShareButton(movie: movie),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Trailers
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trailers',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...movie.trailers.asMap().entries.map((entry) {
                        final index = entry.key;
                        final trailer = entry.value;
                        return _TrailerItem(
                          trailer: trailer,
                          movieId: movie.id,
                          trailerIndex: index,
                        );
                      }).toList(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends ConsumerWidget {
  final Movie movie;

  const _FavoriteButton({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = movie.isFavorite;
    final color = isFavorite ? Colors.red : Colors.deepPurple;
    final icon = isFavorite ? Icons.favorite : Icons.favorite_border;

    return InkWell(
      onTap: () async {
        // Gọi toggle - UI sẽ tự cập nhật nhờ state đã thay đổi trong provider
        await ref.read(movieListProvider.notifier).toggleFavorite(movie.id);

        // Dùng isFavorite hiện tại để hiển thị thông báo
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(!isFavorite ? 'Added to favorites' : 'Removed from favorites'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      borderRadius: BorderRadius.circular(30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(
              'Favorite',
              style: TextStyle(
                color: color,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _RateButton extends ConsumerWidget {
  final Movie movie;

  const _RateButton({required this.movie});

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
                    const SnackBar(content: Text('Rating saved!')),
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
    return InkWell(
      onTap: () => _showRateDialog(context, ref),
      borderRadius: BorderRadius.circular(30),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.deepPurple, size: 28),
            SizedBox(height: 4),
            Text(
              'Rate',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShareButton extends ConsumerWidget {
  final Movie movie;

  const _ShareButton({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sharing ${movie.title}...'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      borderRadius: BorderRadius.circular(30),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.share, color: Colors.deepPurple, size: 28),
            SizedBox(height: 4),
            Text(
              'Share',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
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
          // Gọi toggle - UI sẽ tự cập nhật
          ref.read(movieListProvider.notifier).toggleTrailerWatched(movieId, trailerIndex);
        },
      ),
    );
  }
}
