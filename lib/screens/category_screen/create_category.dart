import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/models/category.dart';
import 'package:reminder/services/category_service.dart';
import 'package:reminder/services/event_service.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/themes/theme_color.dart';

class CreateCategoryWidget extends StatefulWidget {
  final Category category;
  final bool isEdit;

  CreateCategoryWidget({Key key, this.category, this.isEdit}) : super(key: key);

  @override
  _CreateCategoryWidgetState createState() => _CreateCategoryWidgetState();
}

class _CreateCategoryWidgetState extends State<CreateCategoryWidget> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _icons = [
    'Personal',
    'Study',
    'Work',
    'Appoinment',
    'Other'
  ];

  final List<String> _colors = [
    'Personal',
    'Study',
    'Work',
    'Appoinment',
    'Other'
  ];

  //form values
  DocumentReference _reference;
  String _categoryName;
  IconData _categoryIcon;
  Color _categoryColor;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      _reference = widget.category.reference;
      _categoryColor = widget.category.color;
      _categoryIcon = widget.category.icon;
      _categoryName = widget.category.name;
    }
  }

  void _validateForm() {
    if (_formKey.currentState.validate()) {
      Category category = new Category(
        reference: _reference,
        color: _categoryColor,
        icon: _categoryIcon,
        name: _categoryName,
      );

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

  Widget _formHeading(String label) {
    return Text(label,
        style: TextStyle(
          color: ThemeColor.darkAccent,
          fontWeight: FontWeight.w600,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25, bottom: 10),
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
                onTap: () {},
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.image, color: Colors.white),
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
                onTap: () {},
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.color_lens, color: Colors.white),
                    backgroundColor: ThemeColor.primaryAccent,
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
