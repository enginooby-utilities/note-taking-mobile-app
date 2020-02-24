library my_prj.globals;

import 'package:flutter/material.dart';
import 'Note.dart';
import 'Checklist.dart';
import 'Format.dart';
import 'Item.dart';

bool showOptionPanel = true;
bool editMode = false;
double sidePadding = 10;
double columnNumber = 1;
Color appBarColor = Colors.grey[800];

Note note1 = Note(title: 'Note 1', content: 'Content of note 1');
Note note2 = Note(title: 'Note 2', content: 'Content of note 2');
List<Note> noteList = [note1, note2];

Item item1 = Item(content: 'Item 1', isChecked: false);
Item item2 = Item(content: 'Item 2', isChecked: true);
Item item3 = Item(content: 'Item 3', isChecked: true);
Item item4 = Item(content: 'Item 4', isChecked: true);

Checklist checklist1 =
    Checklist(title: 'Checklist 1', itemList: <Item>[item1, item2]);
Checklist checklist2 =
    Checklist(title: 'Checklist 2', itemList: <Item>[item3, item4]);
List<Checklist> checkList = [checklist1, checklist2];

List<Format> formatList = [note1, checklist1, note2, checklist2];
