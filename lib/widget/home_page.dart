import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/widget/character_list_page.dart';
import 'package:language_app/widget/character_train_page.dart';
import 'package:language_app/notifier/character_notifier.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final characterNotifier = context.watch<CharacterNotifier>();
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => CharacterListPage()),
                ),
                child: Text("Character List"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => CharacterTrainerPage(
                      characterList: characterNotifier.characters,
                    ),
                  ),
                ),
                child: Text("Character Trainer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
