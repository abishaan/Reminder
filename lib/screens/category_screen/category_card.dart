import 'package:flutter/material.dart';
import 'package:reminder/models/category.dart';
import 'package:reminder/screens/category_screen/create_category.dart';
import 'package:reminder/services/category_service.dart';
import 'package:reminder/themes/theme_color.dart';
import 'package:reminder/utils/constants.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({
    this.category,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            width: 3,
            color: ThemeColor.darkAccent.withAlpha(40),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          splashColor: ThemeColor.lightPurple.withAlpha(20),
          onLongPress: () {
            showDialog<String>(
              context: context,
              builder: (_) => SimpleDialog(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        isScrollControlled: true,
                        context: context,
                        builder: (_) => CreateCategoryWidget(
                            category: category, isEdit: true),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                    onTap: () {
                      CategoryService().deleteCategory(category.reference);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(category.color),
                  child: Icon(
                    IconData(
                      category.iconCodePoint,
                      fontFamily: Constants.iconFontFamily,
                    ),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              Text(
                category.name,
                style: TextStyle(
                    color: ThemeColor.title,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
