import 'package:flutter/material.dart';
import 'package:test_flutter/Global.dart' as Global;

import '../Note.dart';

class EditNote extends StatefulWidget {
  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  Note note;  //note passed from Home page
  TextEditingController _controller, _controller2;

  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller2 = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    _controller2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Global.editMode) {


        note = ModalRoute.of(context).settings.arguments;
        if(note!=null) {
        _controller.text = note.title;
        _controller2.text = note.content;}

    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Global.appBarColor,
          title: Text('Edit'),
          //automaticallyImplyLeading: false, //hide back button on appbar
        ),
        body: Container(
          padding: EdgeInsets.all(Global.sidePadding),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
                controller: _controller,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: 15,
                minLines: 10,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Content',
                ),
                controller: _controller2,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Global.appBarColor,
          child: Icon(
            Icons.check,
          ),
          onPressed: () {
            if (Global.editMode) {
              note.title = _controller.text;
              note.content = _controller2.text;
            } else {
              Global.formatList.add(Note(title: _controller.text, content: _controller2.text));
            }
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
    );
  }
}
