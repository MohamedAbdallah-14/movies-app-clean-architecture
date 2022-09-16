// ignore_for_file: sized_box_for_whitespace

import 'package:app_example/presentation/widgets/search_bar/search_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/genres_and_popular_movies.dart';
import '../widgets/now_playing_movies_listview.dart';
import '../widgets/tabs/tabbar_movies.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            key: const Key('column-test-key'),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3.1,
                // width: 200,
                child: const NowPlayingMoviesScreen(),
              ),
              Container(
                //color: Colors.amber,
                height: MediaQuery.of(context).size.height / 1.6,
                child: const TabGenresWidget(),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                //color: Colors.deepPurpleAccent,
                child: const TabBarMovies(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
