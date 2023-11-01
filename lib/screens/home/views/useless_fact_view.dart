import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_practice/api/useless_facts_api.dart';

import '../../../models/api/useless_facts_response.dart';
import '../../../services/locator.dart';

class UselessFactView extends StatefulWidget {
  final Color color;
  const UselessFactView({
    super.key,
    required this.color,
  });

  @override
  State<UselessFactView> createState() => _UselessFactViewState();
}

class _UselessFactViewState extends State<UselessFactView> {
  final client = locator.get<ChopperClient>();
  UselessFactsResponse? uselessFact;

  Future<void> getUselessFact() async {
    try {
      final response =
          await client.getService<UselessFactsApi>().getUselessFact();
      if (response.isSuccessful && response.body != null) {
        uselessFact = response.body!;
        setState(() {});
      }
    } catch (e, stack) {
      log(
        'Exception: $e',
        stackTrace: stack,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getUselessFact();
  }

  @override
  Widget build(BuildContext context) {
    if (uselessFact != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              'Also, here is a useless fact: ',
              style: GoogleFonts.roboto(
                color: widget.color,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              '"${uselessFact!.text}"',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.color,
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
