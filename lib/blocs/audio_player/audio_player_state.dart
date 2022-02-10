part of 'audio_player_bloc.dart';

@immutable
class AudioPlayerState{
  const AudioPlayerState({
    this.song,
    this.duration = Duration.zero,
    this.position = Duration.zero,
    this.playerState,
    this.haveError = false,
  });

  final Song? song;
  final Duration duration;
  final Duration position;
  final PlayerState? playerState;
  final bool haveError;

  ///[haveError] will default to false is not specify
  ///this is to prevent get error from previous state
  ///[playerState] value is nullable to identify when player currently hidden
  AudioPlayerState copyWith({
    Song? song,
    Duration? duration,
    Duration? position,
    PlayerState? playerState,
    bool? haveError,
  }) {
    return AudioPlayerState(
      song: song ?? this.song,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      playerState: playerState ?? this.playerState,
      haveError: haveError ?? false,
    );
  }
}
