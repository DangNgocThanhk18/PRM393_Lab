import '../models/movie.dart';

class SampleData {
  static const List<Movie> allMovies = [
    Movie(
      title: 'Inception',
      year: 2010,
      genres: ['Action', 'Sci-Fi', 'Thriller'],
      posterUrl:
      'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
      rating: 8.8,
    ),
    Movie(
      title: 'The Dark Knight',
      year: 2008,
      genres: ['Action', 'Drama', 'Crime'],
      posterUrl:
      'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
      rating: 9.0,
    ),
    Movie(
      title: 'Pulp Fiction',
      year: 1994,
      genres: ['Drama', 'Crime'],
      posterUrl:
      'https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg',
      rating: 8.9,
    ),
    Movie(
      title: 'The Grand Budapest Hotel',
      year: 2014,
      genres: ['Comedy', 'Drama'],
      posterUrl:
      'https://image.tmdb.org/t/p/w500/eWdyYQreja6JGCzqHWXpWHDrrTA.jpg',
      rating: 8.1,
    ),
    Movie(
      title: 'Interstellar',
      year: 2014,
      genres: ['Sci-Fi', 'Drama'],
      posterUrl:
      'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
      rating: 8.6,
    ),
    Movie(
      title: 'The Matrix',
      year: 1999,
      genres: ['Action', 'Sci-Fi'],
      posterUrl:
      'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
      rating: 8.7,
    ),
    Movie(
      title: 'Toy Story',
      year: 1995,
      genres: ['Animation', 'Comedy', 'Family'],
      posterUrl:
      'https://image.tmdb.org/t/p/w500/uXDfjJbdP4ijU5ftQSbfTiVfxhU.jpg',
      rating: 8.3,
    ),
    Movie(
      title: 'The Godfather',
      year: 1972,
      genres: ['Drama', 'Crime'],
      posterUrl:
      'https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
      rating: 9.2,
    ),
  ];

  static const List<String> availableGenres = [
    'Action',
    'Drama',
    'Comedy',
    'Sci-Fi',
    'Crime',
    'Thriller',
    'Animation',
    'Family',
  ];

  static const List<String> sortOptions = ['A-Z', 'Z-A', 'Year', 'Rating'];
}