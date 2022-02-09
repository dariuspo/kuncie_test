part of 'search_songs_cubit.dart';

@immutable
abstract class SearchSongsState {}

class SearchSongsInitial extends SearchSongsState {}

class SearchSongsLoading extends SearchSongsState {}

class SearchSongsLoaded extends SearchSongsState {
  final String searchTerm;
  final List<Song> songs;

  SearchSongsLoaded({
    required this.searchTerm,
    required this.songs,
  });
}

class SearchSongsFailed extends SearchSongsState {
  final String errorMessage;
  SearchSongsFailed(this.errorMessage);
}
