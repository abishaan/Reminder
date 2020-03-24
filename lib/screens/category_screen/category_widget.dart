import 'package:flutter/material.dart';
import 'package:reminder/themes/theme_color.dart';

class CategoryWidget extends StatelessWidget {
  final Icon icon;
  final String label;

  const CategoryWidget(this.icon, this.label, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: IconButton(
              icon: icon,
              color: ThemeColor.darkAccent,
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label,
              style: TextStyle(
                  color: ThemeColor.title,
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
