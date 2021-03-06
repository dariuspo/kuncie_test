
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuncie_test/blocs/search_songs/search_songs_cubit.dart';

///To display current query of search result
///currently no used
class CurrentQuery extends StatelessWidget {
  const CurrentQuery({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchSongsCubit, SearchSongsState>(
      builder: (context, state) {
        if(state is SearchSongsLoaded){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
            child: Text("Search result for: ${state.searchTerm}"),
          );
        }
        return Container();
      },
    );
  }
}
