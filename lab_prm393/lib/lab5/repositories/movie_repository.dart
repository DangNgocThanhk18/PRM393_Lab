import '../models/movie.dart';
import '../data/sample_data.dart';

class MovieRepository {
  final List<Movie> _db = sampleMovies;
  Future<List<Movie>> getAll() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.from(_db);
  }
  Future<void> add(Movie movie) async {
    _db.add(movie);
  }
  Future<void> update(Movie updatedMovie) async {
    final index = _db.indexWhere((movie) => movie.id == updatedMovie.id);
    if (index != -1) {
      _db[index] = updatedMovie;
    }
  }
  Future<void> delete(String id) async {
    _db.removeWhere((movie) => movie.id == id);
  }
  Future<Movie?> getById(String id) async {
    try {
      return _db.firstWhere((movie) => movie.id == id);
    } catch (e) {
      return null;
    }
  }
}