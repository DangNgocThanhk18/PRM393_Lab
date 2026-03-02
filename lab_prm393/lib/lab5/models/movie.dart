class Movie {
  final String title;
  final double rating;
  final List<String> genres;
  final String overview;
  final List<Trailer> trailers;

  Movie({
    required this.title,
    required this.rating,
    required this.genres,
    required this.overview,
    required this.trailers,
  });
}

class Trailer {
  final String title;
  bool isWatched;

  Trailer({
    required this.title,
    this.isWatched = false,
  });
}