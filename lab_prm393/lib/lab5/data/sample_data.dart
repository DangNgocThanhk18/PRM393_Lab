import '../models/movie.dart';

final List<Movie> sampleMovies = [
  Movie(
    title: 'Dune: Part Two',
    rating: 8.6,
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    overview: 'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    trailers: [
      Trailer(title: 'Official Trailer #1', isWatched: false),
      Trailer(title: 'IMAX Sneak Peek', isWatched: false),
    ],
  ),
  Movie(
    title: 'Deadpool & Wolverine',
    rating: 8.3,
    genres: ['Action', 'Comedy'],
    overview: 'The multiverse gets messy when Wade Wilson teams up with Wolverine for a not-so-family-friendly mission.',
    trailers: [
      Trailer(title: 'Red Band Trailer', isWatched: true),
      Trailer(title: 'Behind the Scenes', isWatched: false),
    ],
  ),
];