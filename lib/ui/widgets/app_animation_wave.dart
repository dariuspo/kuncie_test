import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class AppVoicePlayerWithAnimation extends StatefulWidget {
  final String voiceURL;
  final String keyName;

  const AppVoicePlayerWithAnimation({
    Key? key,
    required this.voiceURL,
    required this.keyName,
  }) : super(key: key);

  @override
  _AppVoicePlayerWithAnimationState createState() =>
      _AppVoicePlayerWithAnimationState();
}

class _AppVoicePlayerWithAnimationState
    extends State<AppVoicePlayerWithAnimation>
    with SingleTickerProviderStateMixin {
  Artboard? _riveArtBoard;
  late RiveAnimationController _controller;
  bool isOnPlayVoice = false;
  late FlutterSoundPlayer player;

  _playVoice() async {
    if (isOnPlayVoice == false) {
      await player.openAudioSession();
      await player.startPlayer(
        fromURI: widget.voiceURL,
        whenFinished: () {
          player.closeAudioSession();
          setState(() {
            isOnPlayVoice = false;
            _controller.isActive = false;
          });
        },
      );
      setState(() => _controller.isActive = true);
      isOnPlayVoice = true;
    } else {
      if (player.isPlaying) {
        await player.pausePlayer();
        setState(() => _controller.isActive = false);
      } else if (player.isPaused) {
        await player.resumePlayer();
        setState(() => _controller.isActive = false);
      }
    }
    // update state
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    rootBundle.load('animations/sound.riv').then(
          (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artBoard = file.mainArtboard;
        // Add a controller to play back a known animation on the main/default
        // artboard.We store a reference to it so we can toggle playback.
        artBoard.addController(_controller = SimpleAnimation('play'));
        _controller.isActive = false;
        setState(() => _riveArtBoard = artBoard);
      },
    );

    player = FlutterSoundPlayer();
  }

  @override
  void dispose() {
    player.closeAudioSession();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _playVoice,
      child: VisibilityDetector(
        key: Key(widget.keyName),
        onVisibilityChanged: (info) async {
          if (info.visibleFraction == 0) {
            if (player.isPlaying) {
              await player.pausePlayer();
              setState(() => _controller.isActive = false);
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF23BF9A),
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 4.0,
            vertical: 2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                player.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 22,
                color: Colors.white,
              ),
              const SizedBox(
                width: 5,
              ),
              _riveArtBoard == null
                  ? const SizedBox()
                  : SizedBox(
                  width: 18,
                  height: 18,
                  child: Rive(artboard: _riveArtBoard!)),
              const SizedBox(
                width: 8.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
