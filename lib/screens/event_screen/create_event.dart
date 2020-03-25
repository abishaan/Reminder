import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final List<String> _categories = [
    'Personal',
    'Study',
    'Work',
    'Appoinment',
    'Other'
  ];

  //form values
  DocumentReference _reference;
  String _eventTitle;
  String _eventDescription;
  String _eventCategory;
  DateTime _eventDate;
  TimeOfDay _eventTime;

  @override
  void initState() {
    if (widget.isEdit) {
      _reference = widget.event.reference;
      _eventTitle = widget.event.title;
      _eventDescription = widget.event.description;
      _eventCategory = widget.event.category;
      _eventDate = DateFormat("yyyy-MM-dd").parse(widget.event.remindDate);
      _eventTime = TimeOfDay.fromDateTime(
          DateFormat.jm().parse(widget.event.remindTime));
    }
    super.initState();
  }

  Future<DateTime> _inputRemindDate(BuildContext context) => showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025),
        initialDate: widget.isEdit ? _eventDate : DateTime.now(),
      );

  Future<TimeOfDay> _inputRemindTime(BuildContext context) => showTimePicker(
        context: context,
        initialTime: widget.isEdit ? _eventTime : TimeOfDay.now(),
      );

  void _validateForm() {
    if (_formKey.currentState.validate()) {
//      _formKey.currentState.save();

      if (_eventDate != null && _eventTime != null) {
        RemindEvent event = new RemindEvent(
            reference: _reference,
            title: _eventTitle,
            description: _eventDescription,
            category: _eventCategory,
            remindDate: DateFormat("yyyy-MM-dd")
                .parse(_eventDate.toString())
                .toString(),
            remindTime: _eventTime.format(context).toString());

        if (event != null) {
          if (widget.isEdit) {
            EventService().updateEvent(event);
          } else {
            EventService().addEvent(event);
          }
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
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _formHeading('Title'),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.grey[600]),
                  initialValue: _eventTitle != null ? _eventTitle : null,
                  decoration: InputDecoration(
                    hintText: 'Enter event title',
                  ),
                  validator: (value) =>
                      value.isEmpty ? 'Please enter event title' : null,
                  onChanged: (value) => setState(() => _eventTitle = value),
                ),
              ),
              _formHeading('Description'),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
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
                ),
              ),
              _formHeading('Category'),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0,),
                child: DropdownButtonFormField(
                  value: _eventCategory != null ? _eventCategory : null,
                  items: _categories
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text('$category', style: TextStyle(color: Colors.grey[600])),
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
              _formHeading('Remind date'),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
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
              _formHeading('Remind time'),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
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
                padding: const EdgeInsets.only(bottom: 20.0),
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
