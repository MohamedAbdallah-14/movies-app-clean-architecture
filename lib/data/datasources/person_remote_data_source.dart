import 'package:app_example/data/models/person_images.dart';
import 'package:dio/dio.dart';

import '../../core/errors/exceptions.dart';
import '../../core/http_client/http_client.dart';
import '../../core/utils/api_utils.dart';
import '../models/person_model.dart';

abstract class PersonRemoteDataSource {
  Future<PersonModel> getPersonDetails(int personId);
  Future<PersonImages> getPersonImages(int personId);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final HttpClient client;

  const PersonRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<PersonModel> getPersonDetails(int personId) async {
    Response response = await client.get(ApiUrls.personDetails(personId));
    final personModel = PersonModel.fromJson(response.data);
    //print(genresList.genres);
    if (response.statusCode == 200) {
      return personModel;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }

  @override
  Future<PersonImages> getPersonImages(int personId) async{
    Response response = await client.get(ApiUrls.personImages(personId));
    final images = PersonImages.fromJson(response.data);
    //print(genresList.genres);
    if (response.statusCode == 200) {
      return images;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }
}
