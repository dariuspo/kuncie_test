import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuncie_test/blocs/playing_song/playing_song_cubit.dart';
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

  _toggleState(bool isPlaying) async {
    setState(() => _controller.isActive = isPlaying);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/animations/sound.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artBoard = file.mainArtboard;
        // Add a controller to play back a known animation on the main/default
        // artboard.We store a reference to it so we can toggle playback.
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

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return _riveArtBoard == null
        ? const SizedBox()
        : BlocListener<PlayingSongCubit, PlayingSongState>(
            listener: (context, state) {
              if (state is PlayingSongIsPlaying) {
                if (state.playerState == PlayerState.PLAYING) {
                  _toggleState(true);
                } else {
                  _toggleState(false);
                }
              }
            },
            child: Container(
              padding: EdgeInsets.all(4),
              width: 25,
              height: 25,
              decoration: BoxDecoration(
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
