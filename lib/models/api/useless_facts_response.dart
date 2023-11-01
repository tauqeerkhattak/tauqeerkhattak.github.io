import 'package:json_annotation/json_annotation.dart';

part 'useless_facts_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UselessFactsResponse {
  final String id;
  final String text;
  final String source;
  final String sourceUrl;
  final String language;
  final String permalink;

  UselessFactsResponse({
    required this.id,
    required this.text,
    required this.source,
    required this.sourceUrl,
    required this.language,
    required this.permalink,
  });

  factory UselessFactsResponse.fromJson(Map<String, dynamic> json) {
    return _$UselessFactsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UselessFactsResponseToJson(this);
  }
}
