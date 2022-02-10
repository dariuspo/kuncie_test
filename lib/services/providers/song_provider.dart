import 'package:dio/dio.dart';
import 'package:kuncie_test/models/song.dart';
import 'package:retrofit/retrofit.dart';

part 'song_provider.g.dart';

///Using retrofit to auto generate dio request
@RestApi()
abstract class SongProvider {
  factory SongProvider(Dio dio, {String baseUrl}) = _SongProvider;

  @GET("")
  Future<List<Song>> searchSong({
    @Query("entity") String entity = "song",
    @Query("media") String media = "music",
    @Query("attribute") String attribute = "artistTerm",
    @Query("term") required String term,
  });
}
