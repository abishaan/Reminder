import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reminder/models/category.dart';
import 'package:reminder/services/event_service.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/themes/theme_color.dart';

class CreateEventWidget extends StatefulWidget {
  final RemindEvent event;
  final bool isEdit;

  CreateEventWidget({Key key, this.event, this.isEdit}) : super(key: key);

  @override
  _CreateEventWidgetState createState() => _CreateEventWidgetState();
}

class _CreateEventWidgetState extends State<CreateEventWidget> {
  final _formKey = GlobalKey<FormState>();

  //form values
  DocumentReference _reference;
  String _id;
  String _eventDescription;
  String _eventCategory;
  DateTime _eventDate;
  TimeOfDay _eventTime;
  Map<String, int> _categoryColorMap;

  @override
  void initState() {
    super.initState();
    _categoryColorMap = {
      'Personal': Colors.pink.value,
      'Work': Colors.purple.value,
      'Other': Colors.red.value
    };

    if (widget.isEdit) {
      _id = widget.event.id;
      _reference = widget.event.reference;
      _eventDescription = widget.event.description;
      _eventCategory = widget.event.category;
      _eventDate = DateFormat("yyyy-MM-dd").parse(widget.event.remindDate);
      _eventTime = TimeOfDay.fromDateTime(
          DateFormat.jm().parse(widget.event.remindTime));
    }
  }

  Future<DateTime> _inputRemindDate(BuildContext context) => showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025),
        initialDate:
            widget.isEdit ? _eventDate ?? DateTime.now() : DateTime.now(),
      );

  Future<TimeOfDay> _inputRemindTime(BuildContext context) => showTimePicker(
        context: context,
        initialTime:
            widget.isEdit ? _eventTime ?? TimeOfDay.now() : TimeOfDay.now(),
      );

  void _validateForm() {
    if (_formKey.currentState.validate() &&
        _eventDate != null &&
        _eventTime != null) {
      RemindEvent event = new RemindEvent(
          id: _id,
          reference: _reference,
          category: _eventCategory,
          categoryColor: _categoryColorMap[_eventCategory],
          description: _eventDescription,
          remindDate:
              DateFormat("yyyy-MM-dd").parse(_eventDate.toString()).toString(),
          remindTime: _eventTime.format(context).toString(),
          timestamp: DateFormat.jm()
              .parse(_eventTime.format(context).toString())
              .millisecondsSinceEpoch);

      if (event != null) {
        if (widget.isEdit) {
          EventService().updateEvent(event);
        } else {
          EventService().addEvent(event);
        }
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> _categoryNames = [];
    final categories = Provider.of<List<Category>>(context) ?? [];

    _categoryNames = ['Personal', 'Work', 'Other'];

    categories.forEach((category) {
      _categoryColorMap[category.name] = category.color;
      _categoryNames.add(category.name);
    });

    _categoryNames.sort((a, b) => a.compareTo(b));

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
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.category, color: Colors.white),
                  backgroundColor: ThemeColor.primaryAccent,
                ),
                title: Text(
                  'Category',
                  style: TextStyle(
                    color: ThemeColor.darkAccent,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: DropdownButtonFormField(
                  value: _eventCategory != null ? _eventCategory : null,
                  items: _categoryNames
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text('$category',
                                style: TextStyle(color: Colors.grey[600])),
                          ))
                      .toList(),
                  decoration: InputDecoration(
                    hintText: 'Event category',
                  ),
                  isDense: true,
                  validator: (value) =>
                      value == null ? 'Please select event category' : null,
                  onChanged: (value) => setState(() => _eventCategory = value),
                ),
              ),
              Divider(),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.description, color: Colors.white),
                  backgroundColor: ThemeColor.primaryAccent,
                ),
                title: Text(
                  'Description',
                  style: TextStyle(
                    color: ThemeColor.darkAccent,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: TextFormField(
                  style: TextStyle(color: Colors.grey[600]),
                  initialValue:
                      _eventDescription != null ? _eventDescription : null,
                  decoration: InputDecoration(
                    hintText: 'Enter event description',
                  ),
                  validator: (value) =>
                      value.isEmpty ? 'Please enter event description' : null,
                  onChanged: (value) =>
                      setState(() => _eventDescription = value),
                  onTap: () {},
                ),
              ),
              Divider(),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(MdiIcons.calendar, color: Colors.white),
                  backgroundColor: ThemeColor.primaryAccent,
                ),
                title: Text(
                  'Remind Date',
                  style: TextStyle(
                    color: ThemeColor.darkAccent,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: TextFormField(
                  onTap: () async {
                    final selectedDate = await _inputRemindDate(context);
                    setState(() {
                      _eventDate = selectedDate;
                    });
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: _eventDate == null
                        ? 'Select your remind date'
                        : DateFormat.yMMMd().format(_eventDate).toString(),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.access_time, color: Colors.white),
                  backgroundColor: ThemeColor.primaryAccent,
                ),
                title: Text(
                  'Remind Time',
                  style: TextStyle(
                    color: ThemeColor.darkAccent,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: TextFormField(
                  onTap: () async {
                    final selectedTime = await _inputRemindTime(context);
                    setState(() {
                      _eventTime = selectedTime;
                    });
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: _eventTime == null
                        ? 'Select your remind time'
                        : _eventTime.format(context),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
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
