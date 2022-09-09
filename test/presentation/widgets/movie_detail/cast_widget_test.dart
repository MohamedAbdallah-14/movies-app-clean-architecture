import 'package:app_example/app_module.dart';
import 'package:app_example/presentation/blocs/cast/bloc/cast_bloc.dart';
import 'package:app_example/presentation/widgets/movie_detail/cast_widget.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

import '../../helpers/make_testable_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final castBloc = Modular.get<CastBloc>();

  setUpAll(() {
    initModules(
      [AppModule()],
    );
  });
  testWidgets('cast widget screen test', (tester) async {
    await tester.pumpWidget(
      makeTestableWidget(
          child: BlocProvider<CastBloc>(
              create: (context) => castBloc,
              child: CastWidget(
                castBloc: castBloc,
              ))),
    );
    await tester.pump();
    //expect(find.byType(ListView), findsOneWidget);
  });
}
