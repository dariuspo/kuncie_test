
import 'package:kuncie_test/models/song.dart';
import 'package:kuncie_test/services/api.dart';
import 'package:kuncie_test/services/providers/song_provider.dart';

class SongRepository {
  static final SongRepository _instance = SongRepository._internal();

  static final SongProvider _provider = SongProvider(
    Api.client,
    baseUrl: 'https://itunes.apple.com/search',
  );

  factory SongRepository() {
    return _instance;
  }

  SongRepository._internal();

  ///Getting players from API
  Future<List<Song>> getSongsByArtistName(String artistName) async {
    final songs =  await _provider.searchSong(term: artistName);
    return songs;
  }
}
