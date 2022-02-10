part of 'audio_player_bloc.dart';

@immutable
abstract class AudioPlayerEvent {}

///Triggered when pressed another song, next, or prev
class PlayNewSong extends AudioPlayerEvent {
  final Song song;
  PlayNewSong(this.song);
}

///Triggered when press play from player
class ResumeSong extends AudioPlayerEvent {}

///Triggered when press pause from player
class PauseSong extends AudioPlayerEvent {}

///Triggered when press stop from player
class StopSong extends AudioPlayerEvent {}

///Triggered when stream of audio player have complete status
class CompleteSong extends AudioPlayerEvent {}

///Triggered by changing slider in player
class SeekTime extends AudioPlayerEvent {
  final Duration time;
  SeekTime(this.time);
}

class DurationChanged extends AudioPlayerEvent {
  final Duration duration;
  DurationChanged(this.duration);
}

class PositionChanged extends AudioPlayerEvent {
  final Duration position;
  PositionChanged(this.position);
}

class PlayerStateChanged extends AudioPlayerEvent {
  final PlayerState playerState;
  PlayerStateChanged(this.playerState);
}


