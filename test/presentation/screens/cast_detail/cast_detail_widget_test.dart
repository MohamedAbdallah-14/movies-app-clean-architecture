import 'dart:convert';
import 'dart:io';

import 'package:app_example/app_module.dart';
import 'package:app_example/core/http_client/http_client.dart' as core_http_client;
import 'package:app_example/presentation/screens/cast/cast__detail_screen.dart';
import 'package:app_example/presentation/widgets/cast_detail/movie_detail_arguments.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements core_http_client.HttpClient {}

void main() {
  final MockHttpClient mockHttpClient = MockHttpClient();

  setUpAll(() {
    HttpOverrides.global = null;
    initModules([
      AppModule()
    ], replaceBinds: [
      Bind.instance<core_http_client.HttpClient>(mockHttpClient),
    ]);
  });

  group('Cast Details screen test', () {
    testWidgets('should test these widgets below', (tester) async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          data: json.decode(fixture(('cast_details_mock_model.json'))),
          requestOptions: RequestOptions(path: ''),
        ),
      );
      final castDetailArgs = CastDetailArgument(2, 'Ahmed Ayman');

      await tester.pumpWidget(MaterialApp(
        home: CastDetailScreen(
          castDetailArgument: castDetailArgs,
        ),
      ));
      await tester.pump();
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.text("Biography"), findsOneWidget);
      expect(find.text("Ahmed Ayman"), findsOneWidget);
      expect(find.byType(CarouselSlider), findsOneWidget);
    });
  });
}
