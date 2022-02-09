import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuncie_test/blocs/playing_song/playing_song_cubit.dart';
import 'package:kuncie_test/blocs/search_songs/search_songs_cubit.dart';
import 'package:kuncie_test/models/song.dart';
import 'package:kuncie_test/ui/screens/home_screen/widgets/list_loading_tile.dart';
import 'package:kuncie_test/ui/widgets/app_animation_wave.dart';
import 'package:kuncie_test/ui/widgets/app_image.dart';

class SongResults extends StatelessWidget {
  const SongResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchSongsCubit, SearchSongsState>(
      builder: (context, state) {
        if (state is SearchSongsLoaded) {
          return ListView.builder(
            padding: EdgeInsets.zero,
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
                  final playState =
                      BlocProvider.of<PlayingSongCubit>(context).state;
                  if (playState is PlayingSongIsPlaying) {

                    if (playState.playerState == PlayerState.PLAYING &&
                        playState.song == song) {
                      return;
                    }
                  }
                  BlocProvider.of<PlayingSongCubit>(context)
                      .playSong(song, PlayerState.PLAYING);
                },

                trailing: BlocBuilder<PlayingSongCubit, PlayingSongState>(
                  builder: (context, state) {
                    if (state is PlayingSongIsPlaying) {
                      return state.song == song
                          ? const AppAnimationWave()
                          : const SizedBox.shrink();
                    }
                    return const SizedBox.shrink();
                  },
                ),
              );
            },
            itemCount: state.songs.length,
          );
        }
        if (state is SearchSongsLoading) {
          return ListLoadingTile();
        }
        return SizedBox.shrink();
      },
    );
  }
}
