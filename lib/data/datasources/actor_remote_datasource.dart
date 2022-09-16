import 'dart:io';

import 'package:app_example/core/errors/exceptions.dart';
import 'package:app_example/core/http_client/http_client.dart';
import 'package:app_example/core/utils/api_utils.dart';
import 'package:app_example/data/models/actor_images_model.dart';
import 'package:app_example/data/models/actor_model.dart';

abstract class IActorRemoteDataSource {
  Future<ActorModel> getActorDetails(String? actorId);

  Future<ActorImagesResponse> getActorImages(String? actorId);
}

class ActorRemoteRemoteDataSource extends IActorRemoteDataSource {
  final HttpClient client;

  ActorRemoteRemoteDataSource(this.client);

  @override
  Future<ActorModel> getActorDetails(String? actorId) async {
    final response = await client.get(ApiUrls.actorDetails(actorId));
    if (response.statusCode == HttpStatus.ok) {
      return ActorModel.fromMap(response.data);
    } else {
      throw const ServerException('Something went wrong!');
    }
  }

  @override
  Future<ActorImagesResponse> getActorImages(String? actorId) async {
    final response = await client.get(ApiUrls.actorImages(actorId));
    if (response.statusCode == HttpStatus.ok) {
      return ActorImagesResponse.fromMap(response.data);
    } else {
      throw const ServerException('Something went wrong!');
    }
  }
}
