import 'package:app_example/presentation/blocs/person_details/person_details_bloc.dart';
import 'package:app_example/presentation/blocs/person_image_bloc.dart/person_image_bloc.dart';
import 'package:app_example/presentation/widgets/actor_widget/actor_detil_arguments.dart';
import 'package:app_example/presentation/widgets/actor_widget/actor_slider_images.dart';
import 'package:app_example/presentation/widgets/actor_widget/actor_widget_data.dart';
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
  var dataBloc = Modular.get<PersonDetailsBloc>();

  @override
  void initState() {
    super.initState();
    personImageBloc.add(
        LoadPersonImageEvent(personId: widget.actorDetilAruments.pesrsonId));
    dataBloc
        .add(LoadPersonDetailsEvent(id: widget.actorDetilAruments.pesrsonId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: personImageBloc),
        BlocProvider.value(value: dataBloc),
      ],
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<PersonImageBloc, PersonImageState>(
                  builder: (context, state) {
                if (state is PersonImageLoaded) {
                  return ActorSliderImages(
                    personImages: state.personImages,
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<PersonDetailsBloc, PersonDetailsState>(
                  bloc: dataBloc,
                  builder: (context, state) {
                    if (state is PersonDetailsLoaded) {
                      return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: ActorDetilsData(
                            name: state.personEntity.name,
                            bigraphy: state.personEntity.description,
                            birthday: state.personEntity.birthday,
                          ));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
