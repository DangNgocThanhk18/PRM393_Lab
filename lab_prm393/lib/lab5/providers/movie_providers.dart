import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';
import '../data/sample_data.dart';

// Provider cho danh sách movies
final movieListProvider = Provider<List<Movie>>((ref) {
  return sampleMovies;
});

// Provider cho trailers của movie được chọn
final trailerListProvider = StateProvider.family<List<Trailer>, String>((ref, movieTitle) {
  final movie = ref.watch(movieListProvider).firstWhere((m) => m.title == movieTitle);
  return movie.trailers.map((t) => Trailer(title: t.title, isWatched: t.isWatched)).toList();
});

// Provider để toggle trạng thái trailer
final trailerToggleProvider = Provider((ref) {
  return (String movieTitle, int index) {
    ref.read(trailerListProvider(movieTitle).notifier).update((state) {
      final newState = [...state];
      newState[index] = Trailer(
        title: newState[index].title,
        isWatched: !newState[index].isWatched,
      );
      return newState;
    });
  };
});