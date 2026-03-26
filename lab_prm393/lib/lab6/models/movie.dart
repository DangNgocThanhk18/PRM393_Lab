class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });

  // Factory method to create a copy with modifications
  Movie copyWith({
    String? title,
    int? year,
    List<String>? genres,
    String? posterUrl,
    double? rating,
  }) {
    return Movie(
      title: title ?? this.title,
      year: year ?? this.year,
      genres: genres ?? this.genres,
      posterUrl: posterUrl ?? this.posterUrl,
      rating: rating ?? this.rating,
    );
  }

  @override
  String toString() {
    return 'Movie(title: $title, year: $year, genres: $genres, rating: $rating)';
  }
}