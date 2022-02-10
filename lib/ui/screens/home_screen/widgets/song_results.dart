import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuncie_test/blocs/audio_player/audio_player_bloc.dart';
import 'package:kuncie_test/blocs/search_songs/search_songs_cubit.dart';
import 'package:kuncie_test/models/song.dart';
import 'package:kuncie_test/ui/screens/home_screen/widgets/list_loading_tile.dart';
import 'package:kuncie_test/ui/widgets/app_animation_wave.dart';
import 'package:kuncie_test/ui/widgets/app_error_widget.dart';
import 'package:kuncie_test/ui/widgets/app_image.dart';
import 'package:line_icons/line_icons.dart';

class SongResults extends StatelessWidget {
  const SongResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchSongsCubit, SearchSongsState>(
      builder: (context, state) {
        if (state is SearchSongsLoaded) {
          if (state.songs.isEmpty) {
            return EmptySearchResult(term: state.searchTerm);
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            itemBuilder: (context, index) {
              Song song = state.songs[index];
              return ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: AppImage(
                    imageUrl: song.artworkUrl100 ?? "",
                  ),
                ),
                title: Text(song.trackName ?? ""),
                subtitle: Text("${song.artistName}\n${song.collectionName}"),
                isThreeLine: true,
                onTap: () {
                  BlocProvider.of<AudioPlayerBloc>(context)
                      .add(PlayNewSong(song));
                },
                trailing: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                  builder: (context, state) {
                    return state.song == song &&
                            state.playerState == PlayerState.PLAYING
                        ? const AppAnimationWave()
                        : const SizedBox.shrink();
                  },
                ),
              );
            },
            itemCount: state.songs.length,
          );
        }
        if (state is SearchSongsLoading) {
          return const ListLoadingTile();
        }
        if (state is SearchSongsFailed) {
          return AppErrorWidget(errorMessage: state.errorMessage);
        }
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(LineIcons.music),
              SizedBox(width: 10),
              Text("Start by searching artists"),
            ],
          ),
        );
      },
    );
  }
}

///handle empty result for [SongResults]
class EmptySearchResult extends StatelessWidget {
  final String term;

  const EmptySearchResult({Key? key, required this.term}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(LineIcons.frowningFace),
        const SizedBox(width: 5),
        const Text("There is no result for:"),
        const SizedBox(width: 5),
        Text(term,
            style: const TextStyle().copyWith(fontWeight: FontWeight.bold)),
      ],
    ));
  }
}
