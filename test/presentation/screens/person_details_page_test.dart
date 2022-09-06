import 'dart:convert';
import 'dart:io';

import 'package:app_example/app_module.dart';
import 'package:app_example/core/http_client/http_client.dart';
import 'package:app_example/presentation/screens/person_details_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import '../../fixtures/fixture_reader.dart';
import '../helpers/make_testable_widget.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MockHttpClient mockHttpClient = MockHttpClient();

  setUpAll(() {
    HttpOverrides.global = null;
    initModules([
      AppModule()
    ], replaceBinds: [
      Bind.instance<HttpClient>(mockHttpClient),
    ]);
  });

  group('person detail page test', () {
    testWidgets(
      "should display these widgets when the response is 200 (success)",
          (tester) async {
        when(() => mockHttpClient.get(any())).thenAnswer(
              (_) async => Response(
            statusCode: 200,
            data: json.decode(fixture(('person_details.json'))),
            requestOptions: RequestOptions(path: ''),
          ),
        );

        await tester.pumpWidget(
          makeTestableWidget(child: const PersonDetailsPage(id: 287,)),
        );
        await tester.pump();
     //   untilCalled(()=> mockHttpClient.get("url"));
        expect(find.byType(SingleChildScrollView), findsOneWidget);
        expect(find.byType(AnimatedSwitcher), findsWidgets);
        expect(find.byType(Material), findsWidgets);
      },
    );

    testWidgets(
      "should display this widget when the response is 400 (failure/error),",
          (tester) async {
        when(() => mockHttpClient.get(any())).thenAnswer(
              (_) async => Response(
            statusCode: 400,
            data: json.decode(fixture(('person_details.json'))),
            requestOptions: RequestOptions(path: ''),
          ),
        );

        await tester.pumpWidget(
          makeTestableWidget(child: const PersonDetailsPage(id: 287,)),
        );
        await tester.pump();
        expect(find.byType(AnimatedSwitcher), findsWidgets);
        expect(find.text('Something went wrong!'), findsWidgets);
      },
    );
  });
  group('person images page test', () {
    testWidgets(
      "should display these widgets when the response is 200 (success)",
          (tester) async {
        when(() => mockHttpClient.get(any())).thenAnswer(
              (_) async => Response(
            statusCode: 200,
            data: json.decode(fixture(('person_images.json'))),
            requestOptions: RequestOptions(path: ''),
          ),
        );

        await tester.pumpWidget(
          makeTestableWidget(child: const PersonDetailsPage(id: 287,)),
        );
        await tester.pump();
        //   untilCalled(()=> mockHttpClient.get("url"));
        expect(find.byType(SingleChildScrollView), findsOneWidget);
        expect(find.byType(AnimatedSwitcher), findsWidgets);
        expect(find.byType(CarouselSlider), findsWidgets);
      },
    );

    testWidgets(
      "should display this widget when the response is 400 (failure/error),",
          (tester) async {
        when(() => mockHttpClient.get(any())).thenAnswer(
              (_) async => Response(
            statusCode: 400,
            data: json.decode(fixture(('person_images.json'))),
            requestOptions: RequestOptions(path: ''),
          ),
        );

        await tester.pumpWidget(
          makeTestableWidget(child: const PersonDetailsPage(id: 287,)),
        );
        await tester.pump();
        expect(find.byType(AnimatedSwitcher), findsWidgets);
        expect(find.text('Something went wrong!'), findsWidgets);
      },
    );
  });
}