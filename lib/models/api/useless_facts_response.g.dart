// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'useless_facts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UselessFactsResponse _$UselessFactsResponseFromJson(
        Map<String, dynamic> json) =>
    UselessFactsResponse(
      id: json['id'] as String,
      text: json['text'] as String,
      source: json['source'] as String,
      sourceUrl: json['source_url'] as String,
      language: json['language'] as String,
      permalink: json['permalink'] as String,
    );

Map<String, dynamic> _$UselessFactsResponseToJson(
        UselessFactsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'source': instance.source,
      'source_url': instance.sourceUrl,
      'language': instance.language,
      'permalink': instance.permalink,
    };
