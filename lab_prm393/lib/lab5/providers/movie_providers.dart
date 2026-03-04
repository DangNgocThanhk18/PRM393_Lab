import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/movie_repository.dart';

// Provider cho Repository
final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieRepository();
});

// Provider cho selected movie ID
final selectedMovieIdProvider = StateProvider<String?>((ref) => null);