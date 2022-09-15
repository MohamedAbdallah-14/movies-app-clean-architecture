import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../blocs/search_movies/bloc/search_movies_bloc.dart';
import '../../themes/theme_colors.dart';
import 'custom_search_movie_delegate.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  SearchBar({Key? key, this.onChanged}) : super(key: key);

  final searchMoviesBloc = Modular.get<SearchMoviesBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchMoviesBloc,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              color: ThemeColors.red,
              child: IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(searchMoviesBloc),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
