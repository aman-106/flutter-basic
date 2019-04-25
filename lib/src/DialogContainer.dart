import 'package:flutter/material.dart';
import 'dart:async';

class DialogContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DialogContainerState();
  }
}

enum Options { option1, option2 }

class DialogContainerState extends State<StatefulWidget> {
  Options _selectedOptionInfo;
  final String dialogOpen = 'Dialog Open';

  void _showSelectedInfo(Options str) {
    setState(() {
      _selectedOptionInfo = str;
    });
  }

  void _selectRadioOptions(Options str) {
    Navigator.pop(context, str);
  }

  Widget _getSelectedOptionContent() {
    if (_selectedOptionInfo != null) {
      final String optionInfo = _selectedOptionInfo == Options.option1
          ? 'Option 1 is selcted '
          : 'Option 2 is selected';
      return Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        child: Text(optionInfo),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 166, 158, 1.0),
          border:
              Border.all(width: 2, color: Color.fromRGBO(255, 104, 107, 1.0)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      );
    }
    return Container();
  }

  Future<void> _selectOptions(BuildContext context) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select option'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: 2, color: Color.fromRGBO(0, 0, 0, 1))),
            // backgroundColor: Color.fromRGBO(165, 255, 214, 1.0),
            children: <Widget>[
              SimpleDialogOption(
                // onPressed: () {
                //   Navigator.pop(context, Options.option1);
                // },
                child: RadioListTile<Options>(
                  title: Text('Test Option 1'),
                  groupValue: _selectedOptionInfo,
                  value: Options.option1,
                  onChanged: _selectRadioOptions,
                ),
              ),
              SimpleDialogOption(
                // onPressed: () {
                //   Navigator.pop(context, Options.option2);
                // },
                child: RadioListTile<Options>(
                  title: Text('Test Option 2'),
                  groupValue: _selectedOptionInfo,
                  value: Options.option2,
                  onChanged: _selectRadioOptions,
                ),
              ),
            ],
          );
        })) {
      case Options.option1:
        _showSelectedInfo(Options.option1);
        break;
      case Options.option2:
        _showSelectedInfo(Options.option2);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: FlatButton(
            child: Text(dialogOpen),
            onPressed: () => _selectOptions(context),
            color: Colors.lightBlue[100],
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2.0, color: Colors.lightBlue[300]),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        _getSelectedOptionContent(),
      ],
    );
  }
}
