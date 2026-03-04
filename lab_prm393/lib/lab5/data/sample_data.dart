import '../models/movie.dart';

final List<Movie> sampleMovies = [
  Movie(
    id: '1',
    title: 'Dune: Part Two',
    posterUrl: 'assets/images/dune.png',
    overview: 'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    rating: 8.6,
    trailers: [
      Trailer(
        id: 'dune1',
        title: 'Official Trailer #1',
        url: 'https://www.youtube.com/watch?v=trailer1',
        isWatched: false,
      ),
      Trailer(
        id: 'dune2',
        title: 'IMAX Sneak Peek',
        url: 'https://www.youtube.com/watch?v=trailer2',
        isWatched: false,
      ),
    ],
    isFavorite: false,
  ),
  Movie(
    id: '2',
    title: 'Deadpool & Wolverine',
    posterUrl: 'assets/images/dp&w.png',
    overview: 'The multiverse gets messy when Wade Wilson teams up with Wolverine for a not-so-family-friendly mission.',
    genres: ['Action', 'Comedy'],
    rating: 8.3,
    trailers: [
      Trailer(
        id: 'dp1',
        title: 'Red Band Trailer',
        url: 'https://www.youtube.com/watch?v=trailer3',
        isWatched: true,
      ),
      Trailer(
        id: 'dp2',
        title: 'Behind the Scenes',
        url: 'https://www.youtube.com/watch?v=trailer4',
        isWatched: false,
      ),
    ],
    isFavorite: false,
  ),
];