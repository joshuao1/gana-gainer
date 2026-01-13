import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/model/character_model.dart';
import 'package:language_app/model/character_session.dart';
import 'package:language_app/notifier/character_notifier.dart';
import 'package:language_app/widget/results_page.dart';
import 'package:language_app/widget/styled_container.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

class CharacterTrainerPage extends StatefulWidget {
  const CharacterTrainerPage({super.key});

  @override
  State<CharacterTrainerPage> createState() => _CharacterTrainerPageState();
}

class _CharacterTrainerPageState extends State<CharacterTrainerPage> {
  // final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  List<Character>? _characterList;
  int index = 0;
  Color boxColor = Colors.white;
  String answer = '';
  Set errors = {};
  final stopwatch = Stopwatch();
  final player = AudioPlayer();

  late FocusNode inputFocusNode;

  @override
  void initState() {
    super.initState();
    stopwatch.start();
    print('stopwatch start');

    inputFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    inputFocusNode.dispose();
    player.dispose();
    super.dispose();
  }

  Future<void> checkAnswer() async {
    print("Expected Answer ${_characterList![index].translation}");
    if (_characterList![index].translation == _controller.value.text) {
      await player.play(AssetSource(_characterList![index].audio));
      setState(() {
        boxColor = Colors.green;
        index += 1;
        answer = '';
        if (index >= _characterList!.length) {
          index = 0;
          stopwatch.stop();
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ResultsPage(
                sessionData: CharacterSession(
                  date: DateTime.now(),
                  content: _characterList!,
                  duration: stopwatch.elapsed,
                  errors: errors.toList(),
                ),
              ),
            ),
          );
        }
      });
      Timer(const Duration(milliseconds: 700), () {
        setState(() {
          boxColor = Colors.white;
        });
      });
    } else {
      setState(() {
        boxColor = Colors.red;
        answer = _characterList![index].translation;
        errors.add(index);
        print('errors added to set');
        print(errors);
      });
      Timer(const Duration(milliseconds: 700), () {
        setState(() {
          boxColor = Colors.white;
        });
      });
    }
    _controller.clear();
    inputFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final characterNotifier = context.watch<CharacterNotifier>();
    _characterList = characterNotifier.characters;

    if (characterNotifier.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: Text("Character Trainer")),
      body: SafeArea(
        child: StyledContainer(
          color: boxColor,
          child: Column(
            spacing: 20,
            children: [
              Text(
                _characterList![index].character,
                style: TextStyle(fontSize: 60),
              ),
              CupertinoTextField(
                controller: _controller,
                autocorrect: false,
                enableSuggestions: false,
                onSubmitted: (String value) {
                  checkAnswer();
                  inputFocusNode.requestFocus();
                },
                autofocus: true,
                focusNode: inputFocusNode,
              ),
              if (answer.isNotEmpty) Text(answer),

              ElevatedButton.icon(
                onPressed: () => checkAnswer(),
                label: Text("Next"),
                icon: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
