class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final String overview;
  final List<String> genres;
  double rating;
  final List<Trailer> trailers;
  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
    this.isFavorite = false,
  });

  Movie copyWith({
    String? id,
    String? title,
    String? posterUrl,
    String? overview,
    List<String>? genres,
    double? rating,
    List<Trailer>? trailers,
    bool? isFavorite,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      posterUrl: posterUrl ?? this.posterUrl,
      overview: overview ?? this.overview,
      genres: genres ?? this.genres,
      rating: rating ?? this.rating,
      trailers: trailers ?? this.trailers,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class Trailer {
  final String id;
  final String title;
  final String url;
  bool isWatched;

  Trailer({
    required this.id,
    required this.title,
    required this.url,
    this.isWatched = false,
  });

  Trailer copyWith({
    String? id,
    String? title,
    String? url,
    bool? isWatched,
  }) {
    return Trailer(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      isWatched: isWatched ?? this.isWatched,
    );
  }
}