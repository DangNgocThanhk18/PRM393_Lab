import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/filter_state.dart';

// Provider cho FilterState
final filterProvider = StateNotifierProvider<FilterNotifier, FilterState>((ref) {
  return FilterNotifier();
});

// StateNotifier để quản lý filter state
class FilterNotifier extends StateNotifier<FilterState> {
  FilterNotifier() : super(const FilterState());

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void toggleGenre(String genre) {
    final newSelectedGenres = Set<String>.from(state.selectedGenres);
    if (newSelectedGenres.contains(genre)) {
      newSelectedGenres.remove(genre);
    } else {
      newSelectedGenres.add(genre);
    }
    state = state.copyWith(selectedGenres: newSelectedGenres);
  }

  void updateSortOption(String sortOption) {
    state = state.copyWith(sortOption: sortOption);
  }

  void clearFilters() {
    state = const FilterState();
  }
}