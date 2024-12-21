// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_story_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddStoryBody _$AddStoryBodyFromJson(Map<String, dynamic> json) => AddStoryBody(
      description: json['description'] as String,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AddStoryBodyToJson(AddStoryBody instance) =>
    <String, dynamic>{
      'description': instance.description,
      'lat': instance.lat,
      'lon': instance.lon,
    };
