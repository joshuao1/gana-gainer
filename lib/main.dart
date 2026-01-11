import 'package:flutter/material.dart';
import 'package:language_app/notifier/character_notifier.dart';
import 'package:language_app/widget/home_page.dart';
import 'package:provider/provider.dart';

import 'package:language_app/data/app_database.dart';
import 'package:language_app/data/character_dao.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await AppDatabase.instance.database;
  final characterDao = CharacterDao(database);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CharacterNotifier(characterDao)..load(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Japaneasy',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      home: HomePage(),
      // CharacterList(),
    );
  }
}
