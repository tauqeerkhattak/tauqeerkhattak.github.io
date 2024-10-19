import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:web_practice/utils/constants.dart';

import '../models/api/useless_facts_response.dart';

part 'useless_facts_api.chopper.dart';

@ChopperApi(baseUrl: Constants.uselessFactsUrl)
abstract class UselessFactsApi extends ChopperService {
  static UselessFactsApi create([ChopperClient? client]) {
    return _$UselessFactsApi(client);
  }

  @FactoryConverter(
    response: convertResponse,
  )
  @Get(path: '/v2/facts/random')
  Future<Response<UselessFactsResponse>> getUselessFact();
}

Response<UselessFactsResponse> convertResponse(Response response) {
  return response.copyWith(
    body: response.body != null
        ? UselessFactsResponse.fromJson(jsonDecode(response.body!))
        : null,
  );
}
