import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entitites.dart/cast_images_entity.dart';
import '../../blocs/cast_detail/bloc/cast_detail_bloc.dart';

class ActorImages extends StatefulWidget {
  const ActorImages({Key? key, required this.personID}) : super(key: key);
  final int personID;
  @override
  State<ActorImages> createState() => _ActorImagesState();
}

class _ActorImagesState extends State<ActorImages> {
  final castDetailBloc = Modular.get<CastDetailBloc>();

  late CastImageEntity castImages;
  @override
  void initState() {
    super.initState();
    castDetailBloc.add(CastImagesEvent(widget.personID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CastDetailBloc>(
      create: (_) => castDetailBloc,
      child: BlocBuilder<CastDetailBloc, CastDetailState>(builder: (ctx, state) {
        if (state is CastDetailInitial || state is CastDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CastDetailLoaded) {
          castImages = state.castImageEntity;
        } else if (state is CastDetailError) {
          return const Text('Error in Cast Details');
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 1.0,
              enlargeCenterPage: true,
            ),
            items: castDetailBloc.imageSlider(castImages.profiles),
          ),
        );
      }),
    );
  }
}
