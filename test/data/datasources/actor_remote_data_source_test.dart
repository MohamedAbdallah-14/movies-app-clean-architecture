import 'dart:convert';

import 'package:app_example/core/errors/exceptions.dart';
import 'package:app_example/core/http_client/http_client.dart';
import 'package:app_example/data/datasources/actor_remote_datasource.dart';
import 'package:app_example/data/models/actor_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';
import '../../models_fake/actor_fake_model.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late IActorRemoteDataSource actorRemoteDataSource;
  late MockHttpClient client;
  const actorId = "10";

  setUp(() {
    client = MockHttpClient();
    actorRemoteDataSource = ActorRemoteRemoteDataSource(client);
  });

  Map<String, dynamic> jsonReader(String name) {
    return json.decode(fixture(name));
  }

  void successMock(String urlExpected, Map<String, dynamic> json) {
    when(() => client.get(urlExpected)).thenAnswer((_) async => Response(
        statusCode: 200,
        data: json,
        requestOptions: RequestOptions(path: urlExpected)));
  }

  void failureMock(String urlExpected, Map<String, dynamic> json) {
    when(() => client.get(urlExpected)).thenAnswer(((_) async => Response(
        data: json,
        statusCode: 404,
        requestOptions: RequestOptions(
          path: urlExpected,
        ))));
  }

  group('get Actor Details', () {
    const actorUrl = '/person/$actorId';
    const actorDetailsJson = 'actor.json';
    test(
      'should call the (client) get method from correct actorUrl',
      () async {
        // arrange
        successMock(actorUrl, jsonReader(actorDetailsJson));
        // act
        await actorRemoteDataSource.getActorDetails(actorId);
        // assert
        verify(() => client.get(actorUrl));
      },
    );

    test(
      'should return a ActorModel from method getActorDetails when the response is success',
      () async {
        // arrange
        successMock(actorUrl, jsonReader(actorDetailsJson));
        // act
        final ActorModel result = await actorRemoteDataSource.getActorDetails(actorId);
        // assert
        expect(result, equals(fakeActorModel));
      },
    );

    test(
      'should throw a ServerException from method getActorDetails when the response code is 404',
      () async {
        // arrange
        failureMock(actorUrl, jsonReader(actorDetailsJson));
        // act
        final result = actorRemoteDataSource.getActorDetails(actorId);
        // assert
        expect(() async => result,
            throwsA(const ServerException('Something went wrong!')));
      },
    );
  });

  group('get Actor Images', () {
    const actorImageUrl = '/person/10/images';
    const actorImagesJson = 'actor_images.json';
    test(
      'should call the (client) get method from correct getActorImages',
      () async {
        // arrange
        successMock(actorImageUrl, jsonReader(actorImagesJson));
        // act
        await actorRemoteDataSource.getActorImages(actorId);
        // assert
        verify(() => client.get(actorImageUrl));
      },
    );

    test(
      'should return a ActorImageResponse from method getActorImages when the response is success',
      () async {
        // arrange
        successMock(actorImageUrl, jsonReader(actorImagesJson));
        // act
        final result = await actorRemoteDataSource.getActorImages(actorId);
        // assert
        expect(result, equals(actorImagesResponse));
      },
    );

    test(
      'should throw a ServerException from method getActorImages when the response code is 404',
      () async {
        // arrange
        failureMock(actorImageUrl, jsonReader(actorImagesJson));
        // act
        final result = actorRemoteDataSource.getActorImages(actorId);
        // assert
        expect(() async => result,
            throwsA(const ServerException('Something went wrong!')));
      },
    );
  });
}
