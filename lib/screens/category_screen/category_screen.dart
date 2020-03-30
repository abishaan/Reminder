import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/models/category.dart';
import 'package:reminder/screens/category_screen/category_widget.dart';
import 'package:reminder/themes/theme_color.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Widget _labelWidget(String label) {
    return Text(
      label,
      maxLines: 1,
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: ThemeColor.primaryAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category>>(context) ?? [];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: _labelWidget('Categories'),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: ListView.builder(
            itemCount: categories.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CategoryWidget(category: categories[index]);
            }),

//        body: ListView(
//          padding: const EdgeInsets.symmetric(horizontal: 15),
//          shrinkWrap: true,
//          children: <Widget>[
//            CategoryWidget(Icons.work, 'Personal', Colors.red),
//            CategoryWidget(Icons.work, 'Work', Colors.purple),
//            CategoryWidget(Icons.timelapse, 'Meeting', Colors.indigo),
//            CategoryWidget(Icons.cake, 'Birthday', Colors.pink),
//            CategoryWidget(Icons.book, 'Study', Colors.orange),
//            // ignore: missing_return
//
//          ],
//        ),
      ),
    );
  }
}
