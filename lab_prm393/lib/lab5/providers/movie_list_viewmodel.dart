import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/movie.dart';
import 'movie_providers.dart';
part 'movie_list_viewmodel.g.dart';

@riverpod
class MovieList extends _$MovieList {
  @override
  Future<List<Movie>> build() async {
    final repository = ref.read(movieRepositoryProvider);
    return repository.getAll();
  }
  Future<void> addMovie(Movie movie) async {
    await ref.read(movieRepositoryProvider).add(movie);
    ref.invalidateSelf();
  }
  Future<void> deleteMovie(String id) async {
    await ref.read(movieRepositoryProvider).delete(id);
    ref.invalidateSelf();
  }

  Future<void> toggleFavorite(String movieId) async {
    final currentMovies = await future;
    final index = currentMovies.indexWhere((m) => m.id == movieId);
    if (index == -1) return;
    final updatedMovie = currentMovies[index].copyWith(
      isFavorite: !currentMovies[index].isFavorite,
    );
    final updatedMovies = List<Movie>.from(currentMovies);
    updatedMovies[index] = updatedMovie;
    state = AsyncValue.data(updatedMovies);
    ref.read(movieRepositoryProvider).update(updatedMovie);
  }

  Future<void> updateRating(String movieId, double newRating) async {
    final currentMovies = await future;

    final index = currentMovies.indexWhere((m) => m.id == movieId);
    if (index == -1) return;

    final updatedMovie = currentMovies[index].copyWith(rating: newRating);

    final updatedMovies = List<Movie>.from(currentMovies);
    updatedMovies[index] = updatedMovie;

    state = AsyncValue.data(updatedMovies);

    ref.read(movieRepositoryProvider).update(updatedMovie);
  }

  Future<void> toggleTrailerWatched(String movieId, int trailerIndex) async {
    final currentMovies = await future;
    final index = currentMovies.indexWhere((m) => m.id == movieId);
    if (index == -1) return;

    final movie = currentMovies[index];
    final updatedTrailers = List<Trailer>.from(movie.trailers);
    updatedTrailers[trailerIndex] = updatedTrailers[trailerIndex].copyWith(
      isWatched: !updatedTrailers[trailerIndex].isWatched,
    );

    final updatedMovie = movie.copyWith(trailers: updatedTrailers);

    final updatedMovies = List<Movie>.from(currentMovies);
    updatedMovies[index] = updatedMovie;

    state = AsyncValue.data(updatedMovies);

    ref.read(movieRepositoryProvider).update(updatedMovie);
  }
}