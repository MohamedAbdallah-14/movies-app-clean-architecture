import 'package:app_example/app_module.dart';
import 'package:app_example/presentation/widgets/actor_widget/actor_slider_images.dart';
import 'package:app_example/presentation/widgets/movie_detail/cast_widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

import '../../../entities_fake/person_images_entity_fake.dart';
import '../../helpers/make_testable_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    initModules(
      [AppModule()],
    );
  });
  
  testWidgets('Slider widget screen test', (tester) async {
    await tester.pumpWidget(
      makeTestableWidget(
          child: ActorSliderImages(
        personImages: [personImagesEntity],
      )),
    );
    await tester.pump();
    //expect(find.byType(ListView), findsOneWidget);
  });
}
