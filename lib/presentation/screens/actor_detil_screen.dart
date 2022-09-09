import 'package:app_example/presentation/blocs/person_image_bloc.dart/person_image_bloc.dart';
import 'package:app_example/presentation/widgets/movie_detail/actor_detil_arguments.dart';
import 'package:app_example/presentation/widgets/movie_detail/actor_slider_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ActorDetilScreen extends StatefulWidget {
  final ActorDetilAruments actorDetilAruments;

  const ActorDetilScreen({Key? key, required this.actorDetilAruments})
      : super(key: key);

  @override
  State<ActorDetilScreen> createState() => _ActorDetilScreenState();
}

class _ActorDetilScreenState extends State<ActorDetilScreen> {
  final personImageBloc = Modular.get<PersonImageBloc>();
  @override
  void initState() {
    super.initState();
    personImageBloc.add(
        LoadPersonImageEvent(personId: widget.actorDetilAruments.pesrsonId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonImageBloc>(
        create: (_) => personImageBloc,
        child: BlocBuilder<PersonImageBloc, PersonImageState>(
            builder: (context, state) {
          if (state is PersonImageLoaded) {
            return Scaffold(
              appBar: AppBar(backgroundColor: Colors.transparent),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ActorSliderImages(
                      personImages: state.personImages,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      widget.actorDetilAruments.namePerson!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        }));
  }
}
