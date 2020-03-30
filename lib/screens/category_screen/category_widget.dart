import 'package:flutter/material.dart';
import 'package:reminder/models/category.dart';
import 'package:reminder/themes/theme_color.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;

  const CategoryWidget({
    this.category,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(category.name),
      child: Card(
        elevation: 2,
        shape: Border(left: BorderSide(color: category.color, width: 3),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: Icon(
                category.icon,
                color: category.color,
                size: 30,
              ),
            ),
            Text(
              category.name,
              style: TextStyle(
                  color: ThemeColor.title,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
