import 'dart:io';

import 'package:app_example/app_module.dart';
import 'package:app_example/domain/usecases/get_videos_usecase.dart';
import 'package:app_example/presentation/blocs/videos/bloc/videos_bloc.dart';
import 'package:app_example/presentation/widgets/movie_detail/videos_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import '../../helpers/make_testable_widget.dart';

class MockGetVideosUsecase extends Mock implements GetVideosUsecase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late VideosBloc videosBloc;
  MockGetVideosUsecase mockGetVideosUsecase;
  setUpAll(() {
    HttpOverrides.global = null;
    initModules(
      [AppModule()],
    );
    mockGetVideosUsecase = MockGetVideosUsecase();
    videosBloc = VideosBloc(mockGetVideosUsecase);
  });
  testWidgets('videos widget screen test', (tester) async {
    await tester.pumpWidget(
      makeTestableWidget(child: VideosWidget(videosBloc: videosBloc)),
    );
    await tester.pump();
  });
}
