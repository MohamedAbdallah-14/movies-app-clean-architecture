import 'package:app_example/domain/entitites.dart/cast_images_entity.dart';
import 'package:app_example/presentation/blocs/cast_detail/bloc/cast_detail_bloc.dart';
import 'package:app_example/presentation/screens/cast/actor_images.dart';
import 'package:app_example/presentation/widgets/cast_detail/movie_detail_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'actor_details_screen.dart';

class CastDetailScreen extends StatefulWidget {
  final CastDetailArgument castDetailArgument;

  const CastDetailScreen({Key? key, required this.castDetailArgument}) : super(key: key);

  @override
  State<CastDetailScreen> createState() => _CastDetailState();
}

class _CastDetailState extends State<CastDetailScreen> {
  final castDetailBloc = Modular.get<CastDetailBloc>();
  late CastImageEntity castImages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    castDetailBloc.add(CastImagesEvent(widget.castDetailArgument.personID));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.castDetailArgument.persionName),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ActorImages(
              personID: widget.castDetailArgument.personID,
            ),
            const SizedBox(
              height: 20,
            ),
            ActorDetailsView(
              personID: widget.castDetailArgument.personID,
            )
          ],
        ),
      ),
    );
  }
}
