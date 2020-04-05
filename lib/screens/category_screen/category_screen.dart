import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/models/category.dart';
import 'package:reminder/screens/category_screen/category_card.dart';
import 'package:reminder/shared/empty_image_widget.dart';
import 'package:reminder/utils/theme_color.dart';

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
          fontSize: 25,
          fontWeight: FontWeight.w800,
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
        body: categories.length > 0
            ? ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CategoryCard(category: categories[index]);
                })
            : ListView(
                children: <Widget>[
                  EmptyImageWidget(
                      title: 'You have no categories for your events.',
                      subtitle:
                          'Create some categories? Tap + to write them down.',
                      imagePath: 'assets/images/archive.png'),
                ],
              ),
      ),
    );
  }
}
