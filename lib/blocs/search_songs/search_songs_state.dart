part of 'search_songs_cubit.dart';

@immutable
abstract class SearchSongsState extends Equatable {}

class SearchSongsInitial extends SearchSongsState {
  @override
  List<Object> get props => [];
}

class SearchSongsLoading extends SearchSongsState {
  @override
  List<Object> get props => [];
}

class SearchSongsLoaded extends SearchSongsState {
  final String searchTerm;
  final List<Song> songs;

  SearchSongsLoaded({
    required this.searchTerm,
    required this.songs,
  });

  @override
  List<Object> get props => [searchTerm, songs];
}

class SearchSongsFailed extends SearchSongsState {
  final String errorMessage;

  SearchSongsFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
