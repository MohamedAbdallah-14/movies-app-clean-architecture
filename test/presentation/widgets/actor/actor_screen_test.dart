import 'dart:convert';

import 'package:app_example/app_module.dart';
import 'package:app_example/core/http_client/http_client.dart';
import 'package:app_example/presentation/screens/actor_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../helpers/make_testable_widget.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MockHttpClient mockHttpClient = MockHttpClient();

  setUpAll(() {
    initModules([
      AppModule(),
    ], replaceBinds: [
      Bind.instance<HttpClient>(mockHttpClient),
    ]);
  });
  group('Actor screen', () {
    testWidgets(
      "should return progress indicator with the screen is first loaded",
      (tester) async {
        when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            data: json.decode(fixture(('actor.json'))),
            requestOptions: RequestOptions(path: ''),
          ),
        );

        await tester.pumpWidget(
          makeTestableWidget(child: const ActorScreen()),
        );

        await tester.pump();
        expect(find.byType(ListView), findsNWidgets(1));
        expect(find.byType(AppBar), findsWidgets);
        expect(find.text("actor details"), findsOneWidget);
        expect(find.byType(Center), findsNWidgets(2));
      },
    );

    testWidgets(
      "should return error text widget when the responde is 400",
      (tester) async {
        when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Response(
            statusCode: 400,
            data: json.decode(fixture(('actor.json'))),
            requestOptions: RequestOptions(path: ''),
          ),
        );

        await tester.pumpWidget(
          makeTestableWidget(child: const ActorScreen()),
        );
        await tester.pump();
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(Center), findsNWidgets(2));
      },
    );
  });
}
