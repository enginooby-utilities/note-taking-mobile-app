import 'package:flutter/material.dart';
import 'package:test_flutter/pages/EditChecklist.dart';
import 'package:test_flutter/pages/Home.dart';
import 'package:test_flutter/pages/EditNote.dart';

void main() => runApp(MaterialApp(

    //home: NoteTemplate(),
  theme: ThemeData(
   // primarySwatch: Colors.grey,
  ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/EditNote': (context) => EditNote(),
        '/EditChecklist': (context) => EditChecklist(),
      },
    ));
