import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuncie_test/blocs/audio_player/audio_player_bloc.dart';
import 'package:kuncie_test/ui/themes/color_scheme.dart';
import 'package:rive/rive.dart';
import 'package:audioplayers/audioplayers.dart';

class AppAnimationWave extends StatefulWidget {
  const AppAnimationWave({
    Key? key,
  }) : super(key: key);

  @override
  _AppAnimationWaveState createState() => _AppAnimationWaveState();
}

class _AppAnimationWaveState extends State<AppAnimationWave>
    with SingleTickerProviderStateMixin {
  Artboard? _riveArtBoard;
  late RiveAnimationController _controller;
  bool isOnPlayVoice = false;

  ///Delayed is to handle initial load of the rive [Artboard]
  _toggleState(bool isPlaying) async {
    setState(() => _controller.isActive = isPlaying);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {});
    });
  }

  ///Load the RiveFile from the binary data.
  /// The [Artboard] is the root of the animation and gets drawn in the
  /// Rive widget.
  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/animations/sound.riv').then(
      (data) async {
        final file = RiveFile.import(data);
        final artBoard = file.mainArtboard;
        // Add a controller to play back a known animation on the main/default
        // art board. We store a reference to it so we can toggle playback.
        artBoard.addController(_controller = SimpleAnimation('play'));
        _controller.isActive = true;
        setState(() => _riveArtBoard = artBoard);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Overrid [setState] so it only trigger when artboard still mounted
  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  ///the status of [_riveArtBoard] changed depends of the state of [AudioPlayerBloc]
  @override
  Widget build(BuildContext context) {
    return _riveArtBoard == null
        ? const SizedBox()
        : BlocListener<AudioPlayerBloc, AudioPlayerState>(
            listener: (context, state) {
              if (state.playerState == PlayerState.PLAYING) {
                _toggleState(true);
              } else {
                _toggleState(false);
              }
            },
            child: Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(4),
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: kPrimaryGradient
              ),
              child: Rive(
                artboard: _riveArtBoard!,
              ),
            ),
          );
  }
}
