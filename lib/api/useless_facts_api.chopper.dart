// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'useless_facts_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_string_interpolations, unnecessary_brace_in_string_interps
final class _$UselessFactsApi extends UselessFactsApi {
  _$UselessFactsApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = UselessFactsApi;

  @override
  Future<Response<UselessFactsResponse>> getUselessFact() {
    final Uri $url =
        Uri.parse('https://uselessfacts.jsph.pl/api/v2/facts/random');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UselessFactsResponse, UselessFactsResponse>(
      $request,
      responseConverter: convertResponse,
    );
  }
}
