// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      artistName: json['artistName'] as String?,
      collectionName: json['collectionName'] as String?,
      trackName: json['trackName'] as String?,
      artworkUrl100: json['artworkUrl100'] as String?,
      previewUrl: json['previewUrl'] as String?,
      trackTimeMillis: json['trackTimeMillis'] as int?,
      trackId: json['trackId'] as int?,
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'artistName': instance.artistName,
      'collectionName': instance.collectionName,
      'trackName': instance.trackName,
      'artworkUrl100': instance.artworkUrl100,
      'previewUrl': instance.previewUrl,
      'trackTimeMillis': instance.trackTimeMillis,
      'trackId': instance.trackId,
    };
