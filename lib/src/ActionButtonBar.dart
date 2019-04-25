import 'package:flutter/material.dart';

class ActionButtonBar extends StatefulWidget {
  ActionButtonBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ActionButtonBarState();
  }
}

class ActionButtonBarState extends State<ActionButtonBar> {
  bool _selectAddPhoto = false;
  bool _call = false;
  void _addSelectedPhoto() {
    setState(() {
      _selectAddPhoto = !_selectAddPhoto;
    });
  }

  void _makeCall() {
    setState(() {
      _call = !_call;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add_a_photo),
          onPressed: _addSelectedPhoto,
          color: _selectAddPhoto ? Colors.red : Colors.grey,
        ),
        IconButton(
          icon: Icon(Icons.add_call),
          color: _call ? Colors.red : Colors.grey,
          onPressed: _makeCall,
        )
      ],
    );
  }
}
