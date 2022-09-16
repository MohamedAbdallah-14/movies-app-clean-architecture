import 'package:app_example/presentation/blocs/actor/actor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ActorScreen extends StatefulWidget {
  final String? actorId;
  const ActorScreen({this.actorId, Key? key}) : super(key: key);

  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  final actorDetailsBloc = Modular.get<ActorBloc>();
  final actorImagesBloc = Modular.get<ActorBloc>();
  @override
  void initState() {
    super.initState();
    actorDetailsBloc.add(ActorDetailsEvent(widget.actorId));
    actorImagesBloc.add(ActorImagesEvent(widget.actorId));
  }

  @override
  void dispose() {
    actorDetailsBloc.close();
    actorImagesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("actor details")),
      body: ListView(
        children: [
          BlocBuilder<ActorBloc, ActorState>(
            bloc: actorDetailsBloc,
            builder: (context, state) {
              if (state is ActorDetails) {
                return Column(
                  children: [
                    ListTile(
                      leading: Image.network(
                        state.actorEntity.profilePicture!,
                        fit: BoxFit.fill,
                      ),
                      title: Text(
                        state.actorEntity.name ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        state.actorEntity.birthday ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.actorEntity.biography ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                );
              } else if (state is ActorError) {
                return Center(
                  child: Text(state.message ?? ''),
                );
              } else if (state is ActorLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Actor Images",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
          BlocBuilder<ActorBloc, ActorState>(
            bloc: actorImagesBloc,
            builder: (context, state) {
              if (state is ActorImagesState) {
                if (state.actorImages.isEmpty) {
                  return Center(
                      child: Text('no data found',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.white)));
                }
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                              state.actorImages[index].imagePath!)),
                    ),
                    itemCount: state.actorImages.length,
                  ),
                );
              } else if (state is ActorError) {
                return Center(
                  child: Text(state.message ?? ''),
                );
              } else if (state is ActorLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
