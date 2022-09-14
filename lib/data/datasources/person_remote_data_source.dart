import 'package:app_example/data/models/person_image_model.dart';
import 'package:dio/dio.dart';

import '../../core/errors/exceptions.dart';
import '../../core/http_client/http_client.dart';
import '../../core/utils/api_utils.dart';
import '../models/person_model.dart';

abstract class PersonRemoteDataSource {
  Future<PersonModel> getPersonDetails(int personId);
  Future<PersonImageModel> getPersonImage(int id);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final HttpClient client;

  const PersonRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<PersonModel> getPersonDetails(int personId) async {
    Response response = await client.get(ApiUrls.personDetails(personId));
    final personModel = PersonModel.fromMap(response.data);
    //print(genresList.genres);
    if (response.statusCode == 200) {
      return personModel;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }

  @override
  Future<PersonImageModel> getPersonImage(int id) async {
    Response response = await client.get(ApiUrls.actorImages(id));
    final personImage = PersonImageModel.fromMap(response.data);
    //print(cast.cast[0].castId);
    if (response.statusCode == 200) {
      return personImage;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }
}
