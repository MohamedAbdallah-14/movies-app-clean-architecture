import 'package:dio/dio.dart';

import '../../core/errors/exceptions.dart';
import '../../core/http_client/http_client.dart';
import '../../core/utils/api_utils.dart';
import '../models/Person_image_model.dart';
import '../models/person_model.dart';

abstract class IPersonRemoteDataSource {
  Future<PersonModel> getPersonDetails(int personId);
  Future<PersonImageModel> getPersonImages(int personId);
}

class PersonRemoteDataSourceImpl implements IPersonRemoteDataSource {
  final HttpClient client;

  const PersonRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<PersonModel> getPersonDetails(int personId) async {
    Response response = await client.get(ApiUrls.personDetails(personId));
    final personModel = PersonModel.fromMap(response.data);

    if (response.statusCode == 200) {
      return personModel;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }

  @override
  Future<PersonImageModel> getPersonImages(int personId) async {
    Response response = await client.get(ApiUrls.personImages(personId));
    final images = PersonImageModel.fromMap(response.data);

    if (response.statusCode == 200) {
      return images;
    } else {
      throw const ServerException('Something went wrong!');
    }
  }
}
