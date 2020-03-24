import 'package:flutter/material.dart';
import 'package:reminder/screens/category_screen/category_widget.dart';
import 'package:reminder/shared/label_widget.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            LabelWidget('Categories', 1),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CategoryWidget(Icon(Icons.work), 'Personal'),
                    CategoryWidget(Icon(Icons.book), 'Study'),
                    CategoryWidget(Icon(Icons.timelapse), 'Meeting'),
                    CategoryWidget(Icon(Icons.work), 'Work'),
                    CategoryWidget(Icon(Icons.category), 'Others'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
