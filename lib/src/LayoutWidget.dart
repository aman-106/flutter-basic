import 'package:flutter/material.dart';
import './ActionButtonBar.dart';
import './InformationCard.dart';
import './DialogContainer.dart';
import './RandomWordsList.dart';

class LayoutWidget extends StatelessWidget {
  LayoutWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        ActionButtonBar(),
        InformationCard(),
        DialogContainer(),
        RandomWordsList(),
      ],
    ));
  }
}
