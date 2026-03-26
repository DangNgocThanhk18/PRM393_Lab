import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/sample_data.dart';
import '../providers/filter_provider.dart';

class GenreChips extends ConsumerWidget {
  const GenreChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterProvider);
    final selectedGenres = filterState.selectedGenres;
    final hasActiveFilters = filterState.hasActiveFilters;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ...SampleData.availableGenres.map((genre) {
            final isSelected = selectedGenres.contains(genre);
            return FilterChip(
              label: Text(genre),
              selected: isSelected,
              onSelected: (selected) {
                ref.read(filterProvider.notifier).toggleGenre(genre);
              },
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              selectedColor: Theme.of(context).colorScheme.primaryContainer,
              labelStyle: TextStyle(
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : null,
              ),
            );
          }),
          if (hasActiveFilters)
            ActionChip(
              label: const Text('Clear All'),
              onPressed: () {
                ref.read(filterProvider.notifier).clearFilters();
              },
              avatar: const Icon(Icons.clear, size: 18),
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
        ],
      ),
    );
  }
}