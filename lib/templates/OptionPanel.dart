import 'package:flutter/material.dart';
import 'package:test_flutter/Global.dart' as Global;


import '../Format.dart';

class OptionPanel extends StatelessWidget {
  final Format format;
  final Function delete;

  OptionPanel({this.format, this.delete});
  @override
  Widget build(BuildContext context) {
    if (!Global.showOptionPanel) {
      return Container(
        width: MediaQuery.of(context).size.width / Global.columnNumber -
            (Global.sidePadding * 2),
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width / Global.columnNumber -
          (Global.sidePadding * 2),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      color: format.optionPanelColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print('Favarite ${format.title}');
            },
            child: Icon(
              Icons.star_border,
              color: format.optionPanelIconColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: delete,
            child: Icon(
              Icons.delete_outline,
              color: format.optionPanelIconColor,
            ),
          ),
        ],
      ),
    );
  }
}