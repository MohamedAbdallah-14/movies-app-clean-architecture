const String api_key = "api_key=8f5075af42b17ddc8ffda9abd7fd68fa";

class ApiUrls {
  static String requestImage(String img) =>
      'https://image.tmdb.org/t/p/w500/$img';

  static String popularMovies(int page) => '/movie/popular?$api_key&page=$page';
  static String topRatedMovies(int page) =>
      '/movie/top_rated?$api_key&page=$page';
  static String upcomingMovies(int page) =>
      '/movie/upcoming?$api_key&page=$page';
  static String nowPlaying(int page) =>
      '/movie/now_playing?$api_key&page=$page';
  //static String discoverMovies(int page) => '/discover/movie';
  static String movieGenres() => '/genre/movie/list?$api_key';
  static String searchMovies(String searchText) =>
      '/search/movie?$api_key&query=$searchText';
  static String movie(int id) => '/movie/$id?$api_key';
  static String movieByGenres(int genreId) =>
      '/movie/popular?$api_key&with_genres=$genreId';
  static String movieCredits(int id) => '/movie/$id/credits?$api_key';
  static String movieVideos(int id) => '/movie/$id/videos?$api_key';
  static String actorImages(int id) => '/person/$id/images?$api_key';
  static String personDetails(int id) => '/person/$id?$api_key';

  // static Function similarMovies = (int id) => '/movie/$id/similar';
  static String trendingMovies(int page) =>
      '/trending/movie/day?$api_key&page=$page'; // * timeWindow: day or week
  // static Function trendingPersons =
  //     (String timeWindow) => '/trending/persons/$timeWindow';
  // static Function personDetails = (int id) => '/person/$id';
  // static Function personMovieCredits = (int id) => '/person/$id/movie_credits';
  static String videoThumbnail(String key) =>
      'https://img.youtube.com/vi/$key/0.jpg';
}
