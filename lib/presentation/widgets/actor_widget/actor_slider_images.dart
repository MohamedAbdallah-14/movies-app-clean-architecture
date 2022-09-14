import 'package:app_example/core/utils/api_utils.dart';
import 'package:app_example/domain/entitites.dart/movie_detail_entity.dart';
import 'package:app_example/domain/entitites.dart/person_images_entity.dart';
import 'package:app_example/presentation/widgets/movie_detail/movie_detail_appbar.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class ActorSliderImages extends StatelessWidget {
  final List<PersonImageEntity> personImages;
  const ActorSliderImages({Key? key, required this.personImages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Swiper(
        itemBuilder: (context, index) {
          var personimage = personImages[index];
          return Container(
            decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: personimage.personPathImage == null ||
                            personimage.personPathImage!.isEmpty
                        ? const NetworkImage(
                            'https://www.helptechco.com/files/1215BP6.png')
                        : NetworkImage(
                            ApiUrls.requestImage(
                              personimage.personPathImage!,
                            ),
                          ),
                    fit: BoxFit.fill)),
          );
        },
        indicatorLayout: PageIndicatorLayout.NONE,
        autoplay: false,
        viewportFraction: 0.9,
        scale: 0.9,
        itemCount: personImages.length,
      ),
    );
  }
}
