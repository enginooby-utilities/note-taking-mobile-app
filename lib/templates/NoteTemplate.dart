import 'package:flutter/material.dart';
import 'package:test_flutter/Note.dart';
import 'package:test_flutter/Global.dart' as Global;
import 'package:test_flutter/templates/OptionPanel.dart';

class NoteTemplate extends StatelessWidget {
  final Note note;
  final Function delete;
  NoteTemplate({this.note, this.delete});
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width / 2,
      margin:
          EdgeInsets.fromLTRB(Global.sidePadding, 15, Global.sidePadding, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / Global.columnNumber -
                (Global.sidePadding * 2),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
            color: note.titleColor,
            child: InkWell(
              onTap: () {
                Global.editMode = true;
                Navigator.pushNamed(context, '/EditNote', arguments: note);
              },
              child: Text(
                note.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: note.titleTextColor,
                ),
              ),
            ),
          ),
          //SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width / Global.columnNumber -
                  (Global.sidePadding * 2),
              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
              color: note.contentColor,
              child: InkWell(
                  onTap: () {
                    Global.editMode = true;
                    Navigator.pushNamed(context, '/EditNote', arguments: note);
                  },
                  child: Text(
                    note.content,
                    style: TextStyle(
                      color: note.contentTextColor,
                    ),
                  ))),
          OptionPanel(
            format: note,
            delete: delete,
          ),
        ],
      ),
    );
  }
}


