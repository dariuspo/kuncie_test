import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuncie_test/blocs/audio_player/audio_player_bloc.dart';
import 'package:kuncie_test/ui/widgets/expanded_section.dart';
import 'package:kuncie_test/ui/widgets/player_widget.dart';

///Container of the player
class AppPlayer extends StatefulWidget {
  const AppPlayer({Key? key}) : super(key: key);

  @override
  _AppPlayerState createState() => _AppPlayerState();
}

class _AppPlayerState extends State<AppPlayer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AudioPlayerBloc, AudioPlayerState>(
      listener: (context, state) {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      listenWhen: (prev, curr) {
        if (prev.playerState == null && curr.playerState == PlayerState.PLAYING) {
          return true;
        }
        return false;
      },
      child: ExpandedSection(
        expand: isExpanded,
        child: const PlayerWidget(),
      ),
    );
  }
}
