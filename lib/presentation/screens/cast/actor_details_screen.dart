import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entitites.dart/actor_details_entity.dart';
import '../../blocs/cast_detail/bloc/cast_detail_bloc.dart';

class ActorDetailsView extends StatefulWidget {
  const ActorDetailsView({Key? key, required this.personID}) : super(key: key);
  final int personID;

  @override
  State<ActorDetailsView> createState() => _ActorDetailsViewState();
}

class _ActorDetailsViewState extends State<ActorDetailsView> {
  final castDetailBloc = Modular.get<CastDetailBloc>();

  late ActorDetailsEntity actorDetails;

  @override
  void initState() {
    super.initState();
    castDetailBloc.add(ActorDetailsEvent(widget.personID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CastDetailBloc>(
      create: (_) => castDetailBloc,
      child: BlocBuilder<CastDetailBloc, CastDetailState>(
        builder: (context, state) {
          if (state is CastDetailInitial || state is CastDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ActorDetailsLoaded) {
            actorDetails = state.actorDetailsEntity;
          } else if (state is CastDetailError) {
            return const Text('Deu ruim!');
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gender',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  actorDetails.gender == 2 ? 'Male' : 'Female',
                  style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Biography',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  actorDetails.biography,
                  style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'BirthDate : ',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(actorDetails.birthday.toString(), style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500, fontSize: 16)),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Placce of Birth : ',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(actorDetails.place_of_birth, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500, fontSize: 16)),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
