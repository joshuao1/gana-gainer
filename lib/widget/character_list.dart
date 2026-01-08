import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:language_app/notifier/character_notifier.dart';

class CharacterList extends StatelessWidget {
  CharacterList({super.key});

  @override
  Widget build(BuildContext context) {
    var characterNotifier = context.watch<CharacterNotifier>();

    if (characterNotifier.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Character List')),
      body: SafeArea(
        child: ListView.builder(
          itemCount: characterNotifier.characters.length,
          itemBuilder: (context, index) {
            final character = characterNotifier.characters[index];
            return Container(
              margin: EdgeInsets.all(12.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                    color: Colors.black.withValues(),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(character.character),
                  Text(character.translation),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
