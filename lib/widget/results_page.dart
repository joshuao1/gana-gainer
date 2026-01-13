import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/model/character_session.dart';
import 'package:language_app/widget/styled_container.dart';

class ResultsPage extends StatelessWidget {
  final CharacterSession sessionData;
  const ResultsPage({super.key, required this.sessionData});

  @override
  Widget build(BuildContext context) {
    print("Errors ${sessionData.errors}");
    print("Content ${sessionData.content.length}");
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: SafeArea(
        child: StyledContainer(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("Length: ${sessionData.content.length}"),
              Text("Accuracy: ${sessionData.accuracy()}%"),
              Text("Duration: ${sessionData.duration.inSeconds} seconds"),
            ],
          ),
        ),
      ),
    );
  }
}
