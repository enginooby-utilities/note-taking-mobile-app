import 'package:test_flutter/Format.dart';

import 'Item.dart';

class Checklist extends Format{
  String title;
  List<Item> itemList;

  Checklist({this.title, this.itemList});

}