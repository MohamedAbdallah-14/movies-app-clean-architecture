import '../../core/errors/exceptions.dart';
import '../../core/http_client/http_client.dart';
import '../../core/utils/api_utils.dart';
import '../models/genre_list_model.dart';
import 'package:dio/dio.dart';

abstract class IGenreRemoteDataSource {
  Future<GenreModel> getAllGenres();
}

class GenreRemoteDatasourceImplementation extends IGenreRemoteDataSource {
  final HttpClient client;

  GenreRemoteDatasourceImplementation(this.client);

  @override
  Future<GenreModel> getAllGenres() async {
    Response response = await client.get(ApiUrls.movieGenres());
    // print(response.data);
    final genresList = GenreModel.fromMap(response.data);
    //print(genresList.genres);
    if (response.statusCode == 200) {
      return genresList;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }
}
