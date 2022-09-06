import 'package:app_example/presentation/blocs/person_details/person_details_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/utils/api_utils.dart';
import '../blocs/person_images/person_images_bloc.dart';

class PersonDetailsPage extends StatefulWidget {
  final int id;

  const PersonDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PersonDetailsPageState createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  var imagesBloc = Modular.get<PersonImagesBloc>();
  var dataBloc = Modular.get<PersonDetailsBloc>();

  @override
  void initState() {
    super.initState();
    imagesBloc.add(LoadImagesEvent(id: widget.id));
    dataBloc.add(LoadPersonDetailsEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: imagesBloc),
            BlocProvider.value(value: dataBloc),
          ],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 36,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BlocBuilder<PersonImagesBloc, PersonImagesState>(
                    bloc: imagesBloc,
                    builder: (context, state) {
                      return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: getChild(state));
                    },
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BlocBuilder<PersonDetailsBloc, PersonDetailsState>(
                    bloc: dataBloc,
                    builder: (context, state) {
                      return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: getDataChild(state));
                    },
                  ),
                ),
                const SizedBox(height: 24,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getChild(PersonImagesState state) {
    if (state is PersonImagesLoaded) {
      return CarouselSlider(
        items: state.imagesEntity.images
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      ApiUrls.requestImage(e),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
        ),
      );
    } else if (state is PersonImagesLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is PersonImagesFailure) {
      return Center(
        child: Text(
          state.message,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return Container();
  }

  Widget getDataChild(PersonDetailsState state) {
    if (state is PersonDetailsLoaded) {
      return Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      state.personEntity.name,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 24, fontWeight: FontWeight
                          .bold),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      state.personEntity.birthday,
                      style: const TextStyle(
                          color: Colors.orange, fontSize: 16, fontWeight: FontWeight
                          .bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              Text(state.personEntity.description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              )
            ],
          ),
        ),
      );
    } else if (state is PersonDetailsLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is PersonDetailsFailure) {
      return Center(
        child: Text(
          state.message,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return Container();
  }
}
