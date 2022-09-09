import 'dart:io';

import 'package:app_example/app_module.dart';
import 'package:app_example/presentation/blocs/videos/bloc/videos_bloc.dart';
import 'package:app_example/presentation/widgets/movie_detail/videos_widget.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

import '../../helpers/make_testable_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final videosBloc = Modular.get<VideosBloc>();

  setUpAll(() {
    HttpOverrides.global = null;
    initModules(
      [AppModule()],
    );
  });
  testWidgets('videos widget screen test', (tester) async {
    await tester.pumpWidget(
      makeTestableWidget(
          child: BlocProvider<VideosBloc>(
              create: (context) => videosBloc,
              child: VideosWidget(
                videosBloc: videosBloc,
              ))),
    );
    await tester.pump();
  });
}
