import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isWideScreen;

  const MovieCard({
    super.key,
    required this.movie,
    required this.isWideScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Quan trọng: để column co lại theo nội dung
          children: [
            // Poster Image với AspectRatio cố định
            AspectRatio(
              aspectRatio: 2 / 3,
              child: Image.network(
                movie.posterUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 48,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Movie Info - Phần này sẽ tự động mở rộng
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isWideScreen ? 16 : 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.year.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: isWideScreen ? 12 : 11,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.rating.toStringAsFixed(1),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: isWideScreen ? 12 : 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Genre tags - Wrap sẽ tự động xuống dòng
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    alignment: WrapAlignment.start,
                    children: movie.genres.map((genre) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          genre,
                          style: TextStyle(
                            fontSize: isWideScreen ? 11 : 10,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      );
                    }).toList(),
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