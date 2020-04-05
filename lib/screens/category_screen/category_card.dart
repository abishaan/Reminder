import 'package:flutter/material.dart';
import 'package:reminder/models/category.dart';
import 'package:reminder/screens/category_screen/create_category.dart';
import 'package:reminder/services/category_service.dart';
import 'package:reminder/services/event_service.dart';
import 'package:reminder/utils/custom_alert_dialog.dart';
import 'package:reminder/utils/theme_color.dart';
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
                    onTap: () async {
                      CustomAlertDialog(
                        context: context,
                        message: "Deleting ...",
                      ).show();

                      bool value = await EventService()
                          .checkEventsByCategory(category.name);

                      if (value) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          // user must tap button!
                          builder: (BuildContext context) {
                            return Container(
                              child: AlertDialog(
                                title: Text('Overlapping Events!'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                          'Are you sure you want delete this category including all events?')
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                color:
                                                    ThemeColor.primaryAccent),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('Proceed',
                                              style: TextStyle(
                                                  color: ThemeColor
                                                      .primaryAccent)),
                                          onPressed: () async {
                                            CustomAlertDialog(
                                              context: context,
                                              message: "Deleting Data...",
                                            ).show();

                                            await EventService()
                                                .deleteEventsByCategory(
                                                    category.name);
                                            await CategoryService()
                                                .deleteCategory(
                                                    category.reference);
                                            Navigator.of(context)
                                                .pop(); //delete
                                            Navigator.of(context)
                                                .pop(); // alert
                                            Navigator.of(context)
                                                .pop(); //loading
                                            Navigator.of(context).pop(); //edit
                                          },
                                        ), // button 2
                                      ])
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        CategoryService().deleteCategory(category.reference);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
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
