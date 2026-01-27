import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/notifier/character_notifier.dart';
import 'package:language_app/widget/character_train_page.dart';
import 'package:provider/provider.dart';

class CharacterSelectPage extends StatefulWidget {
  const CharacterSelectPage({super.key});

  @override
  State<CharacterSelectPage> createState() => _CharacterSelectPageState();
}

class _CharacterSelectPageState extends State<CharacterSelectPage> {
  CharacterNotifier? characterNotifier;
  var characterGroups = [
    {'a': true},
    {'ka': true},
    {'sa': true},
    {'ta': true},
    {'na': true},
    {'ha': true},
    {'ma': true},
    {'ya': true},
    {'ra': true},
    {'wa': true},
    {'ga': true},
    {'za': true},
    {'da': true},
    {'ba': true},
    {'pa': true},
    {'kya': true},
    {'sha': true},
    {'cha': true},
    {'nya': true},
    {'hya': true},
    {'mya': true},
    {'rya': true},
    {'gya': true},
    {'ja': true},
    {'bya': true},
    {'pya': true},
  ];
  late var selectedChars = characterGroups;
  @override
  Widget build(BuildContext context) {
    characterNotifier = context.watch<CharacterNotifier>();

    return Scaffold(
      appBar: AppBar(title: const Text('Select Characters')),
      body: SafeArea(
        child: ListView.builder(
          itemCount: characterGroups.length,
          itemBuilder: (context, index) {
            final entry = characterGroups[index].entries;
            // var selectedChars = characterGroups
            //     .where((group) => group.values.first)
            //     .map((group) => group.keys.first)
            //     .toList();
            // print(selectedChars);

            return CheckboxListTile(
              title: Text(entry.first.key),
              activeColor: Colors.blue,
              value: entry.first.value,
              onChanged: (bool? newValue) {
                setState(() {
                  characterGroups[index] = {entry.first.key: newValue!};
                });
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(20)),
          onPressed: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => CharacterTrainerPage(
                characterList: characterNotifier!.characters
                    // Provide list of characters that have been selected in the groups check list
                    .where(
                      (char) => characterGroups
                          .where((group) => group.values.first)
                          .map((group) => group.keys.first)
                          .toList()
                          .contains(char.characterGroup),
                    )
                    .toList(),
              ),
            ),
          ),
          label: Text("Start Training", style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
