import 'package:flutter/material.dart';
import 'package:test_flutter/Checklist.dart';
import 'package:test_flutter/Global.dart' as Global;
import 'package:test_flutter/Item.dart';

import '../Note.dart';

class EditChecklist extends StatefulWidget {
  @override
  _EditChecklistState createState() => _EditChecklistState();
}

class _EditChecklistState extends State<EditChecklist> {
  static int size = 10;
  static Item initItem = Item(content: '', isChecked: false);

  Checklist checklist = Checklist(
      title: '', itemList: <Item>[initItem]); //note passed from Home page
  TextEditingController _controller;
  List<TextEditingController> controllerList = List(size);
  List<ItemForm> itemFormList = List(size);

  void initState() {
    super.initState();
    _controller = TextEditingController();
    for (int i = 0; i < size; i++) {
      controllerList[i] = TextEditingController();
      itemFormList[i] = ItemForm(controller: controllerList[i]);
    }
  }

  void dispose() {
    _controller.dispose();
    for (int i = 0; i < size; i++) {
      controllerList[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Global.editMode) {
      checklist = ModalRoute.of(context).settings.arguments;
      if (checklist != null) {
        _controller.text = checklist.title;
      }
      for (int i = 0; i < checklist.itemList.length; i++) {
        //controllerList[i] = TextEditingController();
        itemFormList[i] = ItemForm(
            controller: controllerList[i], item: checklist.itemList[i]);
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Global.appBarColor,
          title: Text('Edit'),
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
              Container(
                height: 300.0,
                child: ListView(
                  children: itemFormList,
                ),
              )
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
              checklist.title = _controller.text;
              for (int i = 0; i <checklist.itemList.length; i++) {
                  checklist.itemList[i].content=controllerList[i].text;
              }
              for (int i = checklist.itemList.length; i <size; i++) {
                if (controllerList[i].text.length > 0) {
                  Item item =
                  Item(content: controllerList[i].text, isChecked: false);
                  checklist.itemList.add(item);
                }
              }

            } else {
              checklist.title = _controller.text;
              for (int i = 0; i < size; i++) {
                if (controllerList[i].text.length > 0) {
                  Item item =
                      Item(content: controllerList[i].text, isChecked: false);
                  checklist.itemList.add(item);
                }
              }
              checklist.itemList.remove(initItem);
              Global.formatList.add(checklist);
            }
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
    );
  }
}

class ItemForm extends StatefulWidget {
  TextEditingController controller;
  Item item;
  ItemForm({this.controller, this.item});

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  @override
  Widget build(BuildContext context) {
    bool check = false;
    if (widget.item != null) {
      widget.controller.text = widget.item.content;
      check = widget.item.isChecked;
    }
    return SizedBox(
      height: 60,
      child: Row(
        children: <Widget>[
          Checkbox(
            activeColor: Colors.grey[700],
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: check, //widget.item.isChecked,
            onChanged: (bool value) {
              setState(() {
                widget.item.isChecked = value;
              });
            },
          ),
          Flexible(
            child: TextField(
              maxLines: 3,
              minLines: 1,
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                labelText: 'Item',
              ),
              controller: widget.controller,
            ),
          ),
        ],
      ),
    );
  }
}
