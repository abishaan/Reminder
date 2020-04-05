import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/Models/IconPack.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:reminder/models/category.dart';
import 'package:reminder/services/category_service.dart';
import 'package:reminder/utils/custom_alert_dialog.dart';
import 'package:reminder/utils/theme_color.dart';
import 'package:reminder/utils/constants.dart';

class CreateCategoryWidget extends StatefulWidget {
  final Category category;
  final bool isEdit;

  CreateCategoryWidget({Key key, this.category, this.isEdit}) : super(key: key);

  @override
  _CreateCategoryWidgetState createState() => _CreateCategoryWidgetState();
}

class _CreateCategoryWidgetState extends State<CreateCategoryWidget> {
  final _formKey = GlobalKey<FormState>();

  //form values
  DocumentReference _reference;
  String _categoryName;
  IconData _categoryIcon = Icons.image;
  Color _categoryColor = ThemeColor.primaryAccent;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      _reference = widget.category.reference;
      _categoryColor = Color(widget.category.color);
      _categoryIcon = IconData(
        widget.category.iconCodePoint,
        fontFamily: Constants.iconFontFamily,
      );
      _categoryName = widget.category.name;
    }
  }

  _validateForm() {
    if (_formKey.currentState.validate()) {
      Category category = new Category(
          reference: _reference,
          color: _categoryColor.value,
          iconCodePoint: _categoryIcon.codePoint,
          name: _categoryName);

      if (category != null) {
        if (widget.isEdit) {
          CategoryService().updateCategory(category);
        } else {
          CategoryService().addCategory(category);
        }
      }

      Navigator.of(context).pop();
    }
  }

  changeColor(Color color) => setState(() => _categoryColor = color);

  useColorBackground(Color backgroundColor) =>
      1.0 / (backgroundColor.computeLuminance()) > 1.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 35, bottom: 10),
      child: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.text_fields, color: Colors.white),
                    backgroundColor: ThemeColor.primaryAccent,
                  ),
                  title: Text(
                    'Name',
                    style: TextStyle(
                      color: ThemeColor.darkAccent,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  subtitle: TextFormField(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    style: TextStyle(color: Colors.grey[600]),
                    initialValue: _categoryName != null ? _categoryName : null,
                    decoration: InputDecoration(
                      hintText: 'Enter category name',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Please enter category name' : null,
                    onChanged: (value) => setState(() => _categoryName = value),
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () async {
                  CustomAlertDialog(
                    context: context,
                    message: "Loading Icons ...",
                  ).show();

                  IconData icon = await FlutterIconPicker.showIconPicker(
                      context,
                      iconPackMode: IconPack.material);
                  Navigator.pop(context);

                  setState(() {
                    _categoryIcon = icon != null ? icon : Icons.image;
                  });

                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(_categoryIcon, color: Colors.white),
                    backgroundColor: ThemeColor.primaryAccent,
                  ),
                  title: Text(
                    'Icon',
                    style: TextStyle(
                      color: ThemeColor.darkAccent,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  subtitle: Text('Tap to select category icon'),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        titlePadding: const EdgeInsets.all(0.0),
                        contentPadding: const EdgeInsets.all(0.0),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: _categoryColor,
                            onColorChanged: changeColor,
                            pickerAreaHeightPercent: 0.7,
                            showLabel: false,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.color_lens, color: Colors.white),
                    backgroundColor: useColorBackground(_categoryColor)
                        ? _categoryColor
                        : ThemeColor.primaryAccent,
                  ),
                  title: Text(
                    'Color',
                    style: TextStyle(
                      color: ThemeColor.darkAccent,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  subtitle: Text('Tap to select category color'),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
                alignment: Alignment.bottomRight,
                child: OutlineButton(
                  child: Text(
                    widget.isEdit ? 'UPDATE' : 'ADD',
                    style: TextStyle(
                        color: ThemeColor.primaryAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    _validateForm();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
