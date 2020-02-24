import 'package:flutter/material.dart';
import 'package:test_flutter/Item.dart';
import 'package:test_flutter/Global.dart' as Global;
import 'package:test_flutter/templates/OptionPanel.dart';

import '../Checklist.dart';

class ChecklistTemplate extends StatefulWidget {
  final Checklist checklist;
  final Function delete;
  ChecklistTemplate({this.checklist, this.delete});

  @override
  _ChecklistTemplateState createState() => _ChecklistTemplateState();
}

class _ChecklistTemplateState extends State<ChecklistTemplate> {
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
            color: widget.checklist.titleColor,
            child: InkWell(
              onTap: () {
                Global.editMode = true;
                Navigator.pushNamed(context, '/EditChecklist', arguments: widget.checklist);
              },
              child: Text(
                widget.checklist.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.checklist.titleTextColor,
                ),
              ),
            ),
          ),
          //SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width / Global.columnNumber -
                  (Global.sidePadding * 2),
              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
              color: widget.checklist.contentColor,
              child: InkWell(
                  onTap: () {
                    Global.editMode = true;
                    Navigator.pushNamed(context, '/EditChecklist',
                        arguments: widget.checklist);
                  },
                  child: Column(
                    children: widget.checklist.itemList
                        .map((item) => ItemTemplate(item: item,
                      delete: () {
                        setState(() {
                          widget.checklist.itemList.remove(item);
                        });
                      },))

                        .toList(),
                  ))),
          OptionPanel(
            format: widget.checklist,
            delete: widget.delete,
          ),
        ],
      ),
    );
  }
}

class ItemTemplate extends StatefulWidget {
  final Item item;
  final Function delete;

  ItemTemplate({this.item, this.delete});

  @override
  _ItemTemplateState createState() => _ItemTemplateState();
}

class _ItemTemplateState extends State<ItemTemplate> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, //shrink padding of widget
          activeColor: Colors.grey[700],
          value: widget.item.isChecked,
          onChanged: (bool value) {
            setState(() {
              widget.item.isChecked = value;
            });
          },
        ),
        Text(widget.item.content),
        FlatButton.icon(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          color: Colors.grey[400],
            onPressed: widget.delete,
         icon: Icon(Icons.remove_circle_outline), label: Text(''))
      ],
    );
  }
}
