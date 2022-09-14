import 'dart:convert';
import 'dart:io';

import 'package:app_example/app_module.dart';
import 'package:app_example/core/http_client/http_client.dart'
    as core_http_client;
import 'package:app_example/presentation/screens/actor_detil_screen.dart';
import 'package:app_example/presentation/screens/movie_detail_screen.dart';
import 'package:app_example/presentation/widgets/actor_widget/actor_detil_arguments.dart';
import 'package:app_example/presentation/widgets/actor_widget/actor_slider_images.dart';
import 'package:app_example/presentation/widgets/actor_widget/actor_widget_data.dart';
import 'package:app_example/presentation/widgets/movie_detail/cast_widget.dart';
import 'package:app_example/presentation/widgets/movie_detail/movie_detail_arguments.dart';
import 'package:app_example/presentation/widgets/movie_detail/videos_widget.dart';
import 'package:app_example/presentation/widgets/movie_detail_big_poster.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import '../../fixtures/fixture_reader.dart';
import '../helpers/make_testable_widget.dart';

class MockHttpClient extends Mock implements core_http_client.HttpClient {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MockHttpClient mockHttpClient = MockHttpClient();

  setUpAll(() {
    HttpOverrides.global = null;
    initModules([
      AppModule()
    ], replaceBinds: [
      Bind.instance<core_http_client.HttpClient>(mockHttpClient),
    ]);
  });

  group('Actor detail screen test', () {
    testWidgets(
      "should display these widgets when the response is 200 (success)",
      (tester) async {
        when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            data: json.decode(fixture(('person_deitls.json'))),
            requestOptions: RequestOptions(path: ''),
          ),
        );

        await tester.pumpWidget(
          makeTestableWidget(
              child: ActorDetilScreen(
                  actorDetilAruments: ActorDetilAruments(
                      pesrsonId: 238, namePerson: "Marlon Brando"))),
        );
        await tester.pump();
        expect(find.byType(SingleChildScrollView), findsOneWidget);
        // expect(find.byType(ActorSliderImages), findsWidgets);
        expect(find.byType(ActorDetilsData), findsWidgets);
      },
    );

    testWidgets(
      "should display this widget when the response is 400 (failure/error),",
      (tester) async {
        when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Response(
            statusCode: 400,
            data: json.decode(fixture(('person_deitls.json'))),
            requestOptions: RequestOptions(path: ''),
          ),
        );

        await tester.pumpWidget(
          makeTestableWidget(
              child: ActorDetilScreen(
                  actorDetilAruments: ActorDetilAruments(
                      pesrsonId: 238, namePerson: "Marlon Brando"))),
        );
        await tester.pump();
        expect(find.text('Something went wrong!'), findsOneWidget);
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
            data: json.decode(fixture(('person_image.json'))),
            requestOptions: RequestOptions(path: ''),
          ),
        );

        await tester.pumpWidget(
          makeTestableWidget(child: ActorDetilScreen(
                  actorDetilAruments: ActorDetilAruments(
                      pesrsonId: 238, namePerson: "Marlon Brando"))),
        );
        await tester.pump();
        //   untilCalled(()=> mockHttpClient.get("url"));
        expect(find.byType(SingleChildScrollView), findsOneWidget);
        expect(find.byType(Swiper), findsWidgets);
      },
    );

    testWidgets(
      "should display this widget when the response is 400 (failure/error),",
          (tester) async {
        when(() => mockHttpClient.get(any())).thenAnswer(
              (_) async => Response(
            statusCode: 400,
            data: json.decode(fixture(('person_image.json'))),
            requestOptions: RequestOptions(path: ''),
          ),
        );

        await tester.pumpWidget(
          makeTestableWidget(child:ActorDetilScreen(
                  actorDetilAruments: ActorDetilAruments(
                      pesrsonId: 238, namePerson: "Marlon Brando"))),
        );
        await tester.pump();
        expect(find.byType(AnimatedSwitcher), findsWidgets);
        expect(find.text('Something went wrong!'), findsWidgets);
      },
    );
  });
}
