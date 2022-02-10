
import 'package:kuncie_test/models/song.dart';
import 'package:kuncie_test/services/api.dart';
import 'package:kuncie_test/services/providers/song_provider.dart';

///handle request and response related with song search
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

  ///Getting songs based on artist from API
  Future<List<Song>> getSongsByArtistName(String artistName) async {
    final songs =  await _provider.searchSong(term: artistName);
    return songs;
  }
}
