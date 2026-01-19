import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:language_app/notifier/history_notifier.dart';
import 'package:language_app/widget/styled_container.dart';
import 'package:provider/provider.dart';
import 'package:language_app/notifier/character_notifier.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  final player = AudioPlayer();

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var characterNotifier = context.watch<CharacterNotifier>();
    var historyNotifier = context.watch<HistoryNotifier>();

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
            final encounters = historyNotifier.histories
                .where((hist) => hist.characterFk == character.id!)
                .toList();
            final errors = encounters
                .where((hist) => hist.correct == false)
                .toList();
            final accuracy =
                ((encounters.length - errors.length) / encounters.length) * 100;
            return GestureDetector(
              onTap: () => player.play(AssetSource(character.audio)),
              child: StyledContainer(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            character.character,
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(character.translation),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Accuracy: ${accuracy.toStringAsPrecision(3)}%'),
                          Text('Encounters: ${encounters.length}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
