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
            padding: EdgeInsets.fromLTRB(15, 0, 0, 12),
            child: Text(
              label,
              style: TextStyle(
                color: ThemeColor.darkAccent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            bottom: 3,
            left: 15,
            width: 30,
            height: 2.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 1],
                  colors: [
                    ThemeColor.darkAccent.withAlpha(700),
                    ThemeColor.titleColor.withAlpha(700),
                  ],
                ),
              ),
            ),
          ),
          index == 2
              ? Positioned(
                  bottom: 3,
                  left: 50,
                  width: 30,
                  height: 2.5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.1, 1],
                        colors: [
                          ThemeColor.darkAccent.withAlpha(700),
                          ThemeColor.titleColor.withAlpha(700),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
