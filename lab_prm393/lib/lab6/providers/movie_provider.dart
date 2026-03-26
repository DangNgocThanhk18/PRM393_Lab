import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';
import '../data/sample_data.dart';
import 'filter_provider.dart';

// Provider cho danh sách movies đã được filter và sort
final filteredMoviesProvider = Provider<List<Movie>>((ref) {
  final filterState = ref.watch(filterProvider);
  final allMovies = SampleData.allMovies;

  // Filter movies
  List<Movie> filteredMovies = List.from(allMovies);

  // Filter by search query
  if (filterState.searchQuery.isNotEmpty) {
    filteredMovies = filteredMovies.where((movie) =>
        movie.title.toLowerCase().contains(
          filterState.searchQuery.toLowerCase(),
        )).toList();
  }

  // Filter by selected genres
  if (filterState.selectedGenres.isNotEmpty) {
    filteredMovies = filteredMovies.where((movie) =>
        movie.genres.any(
              (genre) => filterState.selectedGenres.contains(genre),
        )).toList();
  }

  // Sort movies
  switch (filterState.sortOption) {
    case 'A-Z':
      filteredMovies.sort((a, b) => a.title.compareTo(b.title));
      break;
    case 'Z-A':
      filteredMovies.sort((a, b) => b.title.compareTo(a.title));
      break;
    case 'Year':
      filteredMovies.sort((a, b) => b.year.compareTo(a.year));
      break;
    case 'Rating':
      filteredMovies.sort((a, b) => b.rating.compareTo(a.rating));
      break;
  }

  return filteredMovies;
});

// Provider cho số lượng movies tìm thấy
final moviesCountProvider = Provider<int>((ref) {
  final movies = ref.watch(filteredMoviesProvider);
  return movies.length;
});