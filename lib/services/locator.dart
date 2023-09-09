import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:web_practice/api/useless_facts_api.dart';

final locator = GetIt.instance;

Future<void> init() async {
  await locator.reset();
  locator.registerFactory(
    () => ChopperClient(
      services: [
        UselessFactsApi.create(),
      ],
    ),
  );
}
