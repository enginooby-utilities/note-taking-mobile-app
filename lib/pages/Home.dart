import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:test_flutter/Note.dart';
import 'package:test_flutter/templates/ChecklistTemplate.dart';
import 'package:test_flutter/templates/CustomDialog.dart';
import 'package:test_flutter/templates/NoteTemplate.dart';
import 'package:test_flutter/Global.dart' as Global;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    IconData showOptionIcon =
        Global.showOptionPanel ? Icons.arrow_drop_up : Icons.arrow_drop_down;
    return SafeArea(
      child: Scaffold(
        drawer: _buildDrawer(context),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Global.appBarColor,
          title: Text('Home'),

//        leading: InkWell(
//          child: Icon(Icons.menu),
//          onTap: () {
//            showDialog(
//              context: context,
//              builder: (BuildContext context) => UnDevDialog(),
//            );
//          },
//        ),
          actions: <Widget>[
            InkWell(
              child: Icon(Icons.search),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => UnDevDialog(),
                );
              },
            ),
            SizedBox(width: 10),
            InkWell(
              child: Icon(Icons.sort),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => UnDevDialog(),
                );
              },
            ),
            SizedBox(width: 10),
            InkWell(
              child: Icon(Icons.view_column),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Number of columns'),
                        content: TextField(
                          controller: _controller,
                          decoration: InputDecoration(hintText: "From 1 to 4"),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: new Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                Global.columnNumber =
                                    double.parse(_controller.text);
                              });
                            },
                          ),
                          FlatButton(
                            child: new Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
                child: Icon(showOptionIcon),
                onTap: () {
                  setState(() {
                    Global.showOptionPanel = !Global.showOptionPanel;
                  });
                }),
            SizedBox(width: 20)
          ],
        ),
        body: SingleChildScrollView(
          child: Wrap(
            children: Global.formatList.map((format) {
              if (format is Note)
                return NoteTemplate(
                  note: format,
                  delete: () {
                    setState(() {
                      Global.formatList.remove(format);
                    });
                  },
                );
              else
                return ChecklistTemplate(
                  checklist: format,
                  delete: () {
                    setState(() {
                      Global.formatList.remove(format);
                    });
                  },
                );
            }).toList(),
          ),
        ),
        floatingActionButton: _getFAB(context),
        /*FloatingActionButton(
          backgroundColor: Global.appBarColor,
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            Global.editMode = false;
            Navigator.pushNamed(context, '/EditChecklist');
          },
        ),*/
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Sidebar'),
            ),
            ListTile(
              title: Text('Item 1'),
              subtitle: Text('Subtitle 1'),
              leading: Icon(Icons.adjust),
              trailing: Icon(Icons.remove),
              selected: true,
            ),
            ListTile(
              title: Text('Item 2'),
            ),
            ListTile(
              title: Text('Item 3'),
            ),
          ],
        ),
      );
  }
}

Widget _getFAB(BuildContext context) {
  return SafeArea(
    child: SpeedDial(
      overlayOpacity: 0.4,
      animatedIcon: AnimatedIcons.add_event,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: Global.appBarColor,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
            child: Icon(Icons.short_text),
            backgroundColor: Global.appBarColor,
            onTap: () {
              Global.editMode = false;
              Navigator.pushNamed(context, '/EditNote');
              /* do anything */
            },
            label: 'Text note',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
            labelBackgroundColor: Global.appBarColor),
        // FAB 2
        SpeedDialChild(
            child: Icon(Icons.list),
            backgroundColor: Global.appBarColor,
            onTap: () {
              Global.editMode = false;
              Navigator.pushNamed(context, '/EditChecklist');
            },
            label: 'Checklist',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
            labelBackgroundColor: Global.appBarColor)
      ],
    ),
  );
}

