import 'package:app_example/app_module.dart';
import 'package:app_example/domain/usecases/get_cast_usecase.dart';
import 'package:app_example/presentation/blocs/cast/bloc/cast_bloc.dart';
import 'package:app_example/presentation/widgets/movie_detail/cast_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import '../../helpers/make_testable_widget.dart';

class MockGetCastUseCase extends Mock implements GetCastUsecase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MockGetCastUseCase mockGetCastUseCase = MockGetCastUseCase();
  CastBloc mockCastBloc = CastBloc(mockGetCastUseCase);
  setUpAll(() {
    initModules(
      [AppModule()],
    );
  });
  testWidgets('cast widget screen test', (tester) async {
    await tester.pumpWidget(
      makeTestableWidget(
          child: CastWidget(
        castBloc: mockCastBloc,
      )),
    );
    await tester.pump();
    //expect(find.byType(ListView), findsOneWidget);
  });
}
