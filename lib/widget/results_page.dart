import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/model/character_model.dart';
import 'package:language_app/model/character_session.dart';
import 'package:language_app/widget/styled_container.dart';

class ResultsPage extends StatelessWidget {
  final CharacterSession sessionData;
  const ResultsPage({super.key, required this.sessionData});

  @override
  Widget build(BuildContext context) {
    List<Character> wrongCharacters = sessionData.content
        .where((char) => sessionData.errors.contains(char.id))
        .toList();
    print("Errors ${sessionData.errors}");
    print("Content ${sessionData.content.length}");
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: SafeArea(
        child: StyledContainer(
          child: Column(
            children: [
              Text("Length: ${sessionData.content.length}"),
              Text("Accuracy: ${sessionData.accuracy()}%"),
              Text("Duration: ${sessionData.duration.inSeconds} seconds"),
              Text(
                "Try Again",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: wrongCharacters.length,
                  itemBuilder: (context, index) {
                    Character wrongCharacter = wrongCharacters[index];
                    return StyledContainer(
                      child: Column(
                        children: [
                          Text(
                            wrongCharacter.character,
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(wrongCharacter.translation),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
