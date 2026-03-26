import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/sample_data.dart';
import '../providers/filter_provider.dart';
import '../providers/movie_provider.dart';

class SortBar extends ConsumerWidget {
  const SortBar({super.key});

  IconData _getSortIcon(String sortOption) {
    switch (sortOption) {
      case 'A-Z':
        return Icons.sort_by_alpha;
      case 'Z-A':
        return Icons.sort_by_alpha;
      case 'Year':
        return Icons.calendar_today;
      case 'Rating':
        return Icons.star;
      default:
        return Icons.sort;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterProvider);
    final moviesCount = ref.watch(moviesCountProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$moviesCount movies found',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButton<String>(
              value: filterState.sortOption,
              underline: const SizedBox(),
              items: SampleData.sortOptions.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Row(
                    children: [
                      Icon(
                        _getSortIcon(option),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(option),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  ref.read(filterProvider.notifier).updateSortOption(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}