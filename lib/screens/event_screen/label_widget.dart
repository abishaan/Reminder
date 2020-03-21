import 'package:flutter/material.dart';
import 'package:reminder/themes/theme_color.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  final int index;

  const LabelWidget(this.label, this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.topLeft,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Text(
              label,
              style: TextStyle(
                color: ThemeColor.darkAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
