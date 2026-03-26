class FilterState {
  final String searchQuery;
  final Set<String> selectedGenres;
  final String sortOption;

  const FilterState({
    this.searchQuery = '',
    this.selectedGenres = const {},
    this.sortOption = 'A-Z',
  });

  FilterState copyWith({
    String? searchQuery,
    Set<String>? selectedGenres,
    String? sortOption,
  }) {
    return FilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedGenres: selectedGenres ?? this.selectedGenres,
      sortOption: sortOption ?? this.sortOption,
    );
  }

  bool get hasActiveFilters {
    return searchQuery.isNotEmpty || selectedGenres.isNotEmpty;
  }

  int get selectedGenresCount => selectedGenres.length;
}