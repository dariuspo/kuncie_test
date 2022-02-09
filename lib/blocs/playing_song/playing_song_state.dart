part of 'playing_song_cubit.dart';

@immutable
abstract class PlayingSongState {}

class PlayingSongInitial extends PlayingSongState {}

class PlayingSongIsPlaying extends PlayingSongState {
  final Song song;

  PlayingSongIsPlaying(this.song);
}