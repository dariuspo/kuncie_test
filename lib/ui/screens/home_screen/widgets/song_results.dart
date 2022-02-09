import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuncie_test/blocs/playing_song/playing_song_cubit.dart';
import 'package:kuncie_test/blocs/search_songs/search_songs_cubit.dart';
import 'package:kuncie_test/models/song.dart';
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
                  BlocProvider.of<PlayingSongCubit>(context).playSong(song);
                },
                trailing: BlocBuilder<PlayingSongCubit, PlayingSongState>(
                  builder: (context, state) {
                    if (state is PlayingSongIsPlaying) {
                      return Icon(
                        state.song == song ? Icons.stop : Icons.play_arrow,
                      );
                    }
                    return Icon(
                      Icons.play_arrow,
                    );
                  },
                ),
              );
            },
            itemCount: state.songs.length,
          );
        }
        return Container(
          color: Colors.red,
        );
      },
    );
  }
}
