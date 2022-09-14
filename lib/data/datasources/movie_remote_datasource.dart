import 'package:app_example/core/errors/exceptions.dart';
import 'package:app_example/core/http_client/http_client.dart';
import 'package:app_example/core/utils/api_utils.dart';
import 'package:app_example/data/models/actor_details_model.dart';
import 'package:app_example/data/models/cast_crew_result_model.dart';
import 'package:app_example/data/models/cast_image_model.dart';
import 'package:app_example/data/models/movie_detail_model.dart';
import 'package:app_example/data/models/movie_results_model.dart';
import 'package:app_example/data/models/video_result_model.dart';
import 'package:dio/dio.dart';

abstract class IMovieRemoteDataSource {
  Future<MovieResultsModel> getMovieByGenre(int genreId);
  Future<MovieResultsModel> getTrendingMovies(int page);
  Future<MovieResultsModel> getUpcomingMovies(int page);
  Future<MovieResultsModel> getTopRatedMovies(int page);
  Future<MovieResultsModel> getPopularMovies(int page);
  Future<MovieResultsModel> getNowPlayingMovies(int page);
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<CastCrewResultModel> getCastCrew(int id);
  Future<VideoResultModel> getVideos(int id);
  Future<MovieResultsModel> getSearchedMovies(String searchText);
  Future<CastImageModel> getCastImages(int personID);
  Future<ActorDetailsModel> getActorDetails(int personID);
}

class MovieRemoteDataSourceImplementation implements IMovieRemoteDataSource {
  final HttpClient client;

  MovieRemoteDataSourceImplementation(this.client);
  @override
  Future<MovieResultsModel> getTrendingMovies(int page) async {
    Response response = await client.get(ApiUrls.trendingMovies(page));

    final movies = MovieResultsModel.fromMap(response.data);
    //print(movies.results);
    if (response.statusCode == 200) {
      return movies;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }

  @override
  Future<MovieResultsModel> getNowPlayingMovies(int page) async {
    try {
      Response response = await client.get(ApiUrls.nowPlaying(page));
      final movies = MovieResultsModel.fromMap(response.data);
      //print(movies.results);
      if (response.statusCode == 200) {
        return movies;
      } else {
        throw const ServerException('Something went wrong!');
      }
    } on DioError catch (e) {
      return MovieResultsModel(
        totalPages: 0,
        totalResults: 1,
        results: [],
        page: 0,
      );
    }
  }

  @override
  Future<MovieResultsModel> getPopularMovies(int page) async {
    Response response = await client.get(ApiUrls.popularMovies(page));

    final movies = MovieResultsModel.fromMap(response.data);
    //debugPrint(movies.title);
    if (response.statusCode == 200) {
      return movies;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }

  @override
  Future<MovieResultsModel> getTopRatedMovies(int page) async {
    Response response = await client.get(ApiUrls.topRatedMovies(page));
    final movies = MovieResultsModel.fromMap(response.data);
    //print(movies.results);
    if (response.statusCode == 200) {
      return movies;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }

  @override
  Future<MovieResultsModel> getUpcomingMovies(int page) async {
    Response response = await client.get(ApiUrls.upcomingMovies(page));
    final movies = MovieResultsModel.fromMap(response.data);
    //print(movies.results);
    if (response.statusCode == 200) {
      return movies;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }

  @override
  Future<MovieResultsModel> getMovieByGenre(int genreId) async {
    Response response = await client.get(ApiUrls.movieByGenres(genreId));
    final movies = MovieResultsModel.fromMap(response.data);
    //print(movies.results);
    if (response.statusCode == 200) {
      return movies;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    Response response = await client.get(ApiUrls.movie(id));
    //print(id);
    final movies = MovieDetailModel.fromMap(response.data);
    //print(movies); //.map((e) => e.toMap()));
    if (response.statusCode == 200) {
      return movies;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }

  @override
  Future<CastCrewResultModel> getCastCrew(int id) async {
    Response response = await client.get(ApiUrls.movieCredits(id));

    final cast = CastCrewResultModel.fromMap(response.data);

    if (response.statusCode == 200) {
      return cast;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }

  @override
  Future<VideoResultModel> getVideos(int id) async {
    Response response = await client.get(ApiUrls.movieVideos(id));
    final videos = VideoResultModel.fromJson(response.data);
    //print(videos.videos[0].id);
    if (response.statusCode == 200) {
      return videos;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }

  @override
  Future<MovieResultsModel> getSearchedMovies(String searchText) async {
    Response response = await client.get(ApiUrls.searchMovies(searchText), queryParameters: {
      'query': searchText,
    });
    final movies = MovieResultsModel.fromJson(response.toString());
    if (response.statusCode == 200) {
      return movies;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }

  @override
  Future<CastImageModel> getCastImages(int personID) async {
    //  print('api url = ${ApiUrls.castImages(personID)}');
    Response response = await client.get(ApiUrls.castImages(personID));

    final castImage = CastImageModel.fromMap(response.data);
    if (response.statusCode == 200) {
      return castImage;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }

  @override
  Future<ActorDetailsModel> getActorDetails(int personID) async {
    Response response = await client.get(ApiUrls.actorDetails(personID));

    final actorDetails = ActorDetailsModel.fromMap(response.data);
    if (response.statusCode == 200) {
      return actorDetails;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }
}
