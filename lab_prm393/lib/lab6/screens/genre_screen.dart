import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/movie_provider.dart';
import '../providers/filter_provider.dart';
import '../widgets/search_bar.dart';
import '../widgets/genre_chips.dart';
import '../widgets/sort_bar.dart';
import '../widgets/empty_state.dart';
import '../widgets/custom_responsive_grid.dart';
import '../widgets/movie_card.dart';

class GenreScreen extends ConsumerWidget {
  const GenreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibleMovies = ref.watch(filteredMoviesProvider);
    final filterState = ref.watch(filterProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Find a Movie',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (filterState.selectedGenresCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${filterState.selectedGenresCount} selected',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Search Bar
            const CustomSearchBar(),
            // Genre Chips
            const GenreChips(),
            // Sort Bar
            const SortBar(),
            const Divider(height: 1),
            // Responsive Movie List
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (visibleMovies.isEmpty) {
                    return EmptyState(
                      onClearFilters: () {
                        ref.read(filterProvider.notifier).clearFilters();
                      },
                    );
                  }

                  final isWideScreen = constraints.maxWidth >= 800;

                  if (isWideScreen) {
                    // Sử dụng CustomResponsiveGrid cho tablet/web
                    return CustomResponsiveGrid(
                      movies: visibleMovies,
                      maxWidth: constraints.maxWidth,
                    );
                  } else {
                    // List layout cho mobile
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: visibleMovies.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: MovieCard(
                            movie: visibleMovies[index],
                            isWideScreen: false,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}