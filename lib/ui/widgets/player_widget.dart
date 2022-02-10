import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuncie_test/blocs/audio_player/audio_player_bloc.dart';
import 'package:kuncie_test/blocs/search_songs/search_songs_cubit.dart';
import 'package:kuncie_test/models/song.dart';
import 'package:line_icons/line_icons.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({
    Key? key,
  }) : super(key: key);

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  static const double iconSize = 20;

  _playNewSong(Song song) async {
    BlocProvider.of<AudioPlayerBloc>(context).add(PlayNewSong(song));
  }

  _play() async {
    BlocProvider.of<AudioPlayerBloc>(context).add(ResumeSong());
  }

  _pause() async {
    BlocProvider.of<AudioPlayerBloc>(context).add(PauseSong());
  }

  _stop() async {
    BlocProvider.of<AudioPlayerBloc>(context).add(StopSong());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      child: BlocConsumer<AudioPlayerBloc, AudioPlayerState>(
        listener: (context, state) {
          if (state.haveError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Failed to play the song"),
            ));
          }
        },
        builder: (context, state) {
          Song? song = state.song;
          bool _isPlaying = state.playerState == PlayerState.PLAYING;
          bool _isPaused = state.playerState == PlayerState.PAUSED;
          Duration _duration = state.duration;
          Duration _position = state.position;
          String _durationText = _duration.toString().split('.').first;
          String _positionText = _position.toString().split('.').first;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildSongInformation(song),
              _buildButtonPlayer(
                _isPlaying,
                _isPaused,
                song,
                _positionText,
                _durationText,
              ),
              _buildSlider(_duration, context, _position),
            ],
          );
        },
      ),
    );
  }

  Visibility _buildSongInformation(Song? song) {
    return Visibility(
      visible: song != null,
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "${song?.trackName} - ${song?.artistName}",
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  Slider _buildSlider(
    Duration _duration,
    BuildContext context,
    Duration _position,
  ) {
    return Slider(
      onChanged: (v) {
        final duration = _duration;
        if (duration == Duration.zero) return;
        final position = v * duration.inMilliseconds;
        BlocProvider.of<AudioPlayerBloc>(context).add(SeekTime(
          Duration(
            milliseconds: position.round(),
          ),
        ));
      },
      value: (_position.inMilliseconds > 0 &&
              _position.inMilliseconds < _duration.inMilliseconds)
          ? _position.inMilliseconds / _duration.inMilliseconds
          : 0.0,
    );
  }

  Row _buildButtonPlayer(bool _isPlaying, bool _isPaused, Song? song,
      String _positionText, String _durationText) {
    return Row(
      children: [
        IconButton(
          onPressed: _isPlaying ? null : _play,
          iconSize: iconSize,
          icon: const Icon(LineIcons.play),
        ),
        IconButton(
          onPressed: _isPlaying ? _pause : null,
          iconSize: iconSize,
          icon: const Icon(LineIcons.pause),
        ),
        IconButton(
          onPressed: _isPlaying || _isPaused ? _stop : null,
          iconSize: iconSize,
          icon: const Icon(LineIcons.stop),
        ),
        BlocBuilder<SearchSongsCubit, SearchSongsState>(
          builder: (context, searchedState) {
            if (searchedState is SearchSongsLoaded) {
              final index =
                  searchedState.songs.indexWhere((element) => element == song);
              return Row(
                children: [
                  IconButton(
                    onPressed: index == 0
                        ? null
                        : () => _playNewSong(searchedState.songs[index - 1]),
                    iconSize: iconSize,
                    icon: const Icon(LineIcons.stepBackward),
                  ),
                  IconButton(
                    onPressed: index == searchedState.songs.length - 1
                        ? null
                        : () => _playNewSong(
                              searchedState.songs[index + 1],
                            ),
                    iconSize: iconSize,
                    icon: const Icon(LineIcons.stepForward),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: FittedBox(
                child: Text(
                  '$_positionText / $_durationText',
                  style: const TextStyle(fontSize: 14.0),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
