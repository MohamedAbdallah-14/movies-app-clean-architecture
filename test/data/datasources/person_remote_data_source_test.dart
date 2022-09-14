import 'dart:convert';

import 'package:app_example/core/errors/exceptions.dart';
import 'package:app_example/core/http_client/http_client.dart';
import 'package:app_example/data/datasources/person_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';
import '../../models_fake/person_image_model_fake.dart';
import '../../models_fake/person_model_fake.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late PersonRemoteDataSourceImpl personRemoteDataSource;
  late HttpClient client;

  setUp(() {
    client = MockHttpClient();
    personRemoteDataSource = PersonRemoteDataSourceImpl(client: client);
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

  group('getPersonDetails', () {
    const urlPerson = '/person/287';
    test(
      'should call the (client) get method from correct urlPerson',
      () async {
        // arrange
        successMock(urlPerson, jsonReader('person_details.json'));
        // act
        await personRemoteDataSource.getPersonDetails(287);
        // assert
        verify(() => client.get(urlPerson));
      },
    );

    test(
      'should return a PersonModel from method getPersonDetails when the response code is 200',
      () async {
        // arrange
        successMock(urlPerson, jsonReader('person_details.json'));
        // act
        final result = await personRemoteDataSource.getPersonDetails(287);
        // assert
        expect(result, equals(personModel));
      },
    );

    test(
      'should throw a ServerException from method getPersonDetails when the response code is 404',
      () async {
        // arrange
        failureMock(urlPerson, jsonReader('person_details.json'));
        // act
        final result = personRemoteDataSource.getPersonDetails(287);
        // assert
        expect(() async => result,
            throwsA(const ServerException('Something went wrong!')));
      },
    );
  });
  group('getPersonImages', () {
    const urlPersonImages = '/person/66633/images';
    test(
      'should call the (client) get method from correct [urlPersonImages]',
      () async {
        // arrange
        successMock(urlPersonImages, jsonReader('person_images.json'));
        // act
        await personRemoteDataSource.getPersonImage(66633);
        // assert
        verify(() => client.get(urlPersonImages));
      },
    );

    test(
      'should return a [PersonImagesModel] from method getPersonImages when the response code is 200',
      () async {
        // arrange
        successMock(urlPersonImages, jsonReader('person_images.json'));
        // act
        final result = await personRemoteDataSource.getPersonImage(66633);
        // assert
        expect(
          result,
          equals(personImageModel),
        );
      },
    );

    test(
      "should throw a [ServerException] from method getAllGenres when the response code is 404",
      () async {
        // arrange
        failureMock(urlPersonImages, jsonReader('person_images.json'));
        // act
        final result = personRemoteDataSource.getPersonImage(66633);
        // assert
        expect(() async => result,
            throwsA(const ServerException('Something went wrong!')));
      },
    );
  });
}
