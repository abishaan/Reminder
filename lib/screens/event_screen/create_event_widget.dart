import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/api/event_api.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/themes/theme_color.dart';

class CreateEventWidget extends StatefulWidget {
  final RemindEvent event;
  final bool isEditMode;

  CreateEventWidget({Key key, this.event, this.isEditMode}) : super(key: key);

  @override
  _CreateEventWidgetState createState() => _CreateEventWidgetState();
}

class _CreateEventWidgetState extends State<CreateEventWidget> {
  DocumentReference _reference;
  String _eventTitle;
  String _eventDescription;
  String _eventCategory;
  DateTime _eventDate;
  TimeOfDay _eventTime;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.isEditMode) {
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

  Future<DateTime> _inputRemindDate(BuildContext context) =>
      showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025),
        initialDate: widget.isEditMode ? _eventDate : DateTime.now(),
      );

  Future<TimeOfDay> _inputRemindTime(BuildContext context) =>
      showTimePicker(
        context: context,
        initialTime: widget.isEditMode ? _eventTime : TimeOfDay.now(),
      );

  void _validateForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      EventAPI eventAPI = new EventAPI();
      if (_eventDate != null && _eventTime != null) {
        RemindEvent event = new RemindEvent(
            reference: _reference,
            title: _eventTitle,
            description: _eventDescription,
            category: _eventCategory,
            remindDate: _eventDate.toString(),
            remindTime: _eventTime.format(context).toString());

        if (event != null) {
          if (widget.isEditMode) {
            print('----------------' + widget.event.toJson().toString());

            eventAPI.updateEvent(event);
          } else {
            eventAPI.addEvent(event);
          }
        }
      }

      Navigator.of(context).pop();
    }
  }

  Widget _textLabel(String label) {
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
        EdgeInsets.only(bottom: MediaQuery
            .of(context)
            .viewInsets
            .bottom),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _textLabel('Title'),
              TextFormField(
                initialValue: _eventTitle != null ? _eventTitle : null,
                decoration: InputDecoration(
                  hintText: 'Event title',
                ),
                validator: (value) =>
                value.isEmpty ? 'Please enter some text' : null,
                onSaved: (value) {
                  _eventTitle = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              _textLabel('Description'),
              TextFormField(
                initialValue:
                _eventDescription != null ? _eventDescription : null,
                decoration: InputDecoration(
                  hintText: 'Describe your task',
                ),
                validator: (value) =>
                value.isEmpty ? 'Please enter some text' : null,
                onSaved: (value) {
                  _eventDescription = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              _textLabel('Category'),
              TextFormField(
                initialValue: _eventCategory != null ? _eventCategory : null,
                decoration: InputDecoration(
                  hintText: 'Event category',
                ),
                validator: (value) =>
                value.isEmpty ? 'Please enter some text' : null,
                onSaved: (value) {
                  _eventCategory = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              _textLabel('Date of the Event'),
              TextFormField(
                onTap: () async {
                  final selectedDate = await _inputRemindDate(context);
                  setState(() {
                    _eventDate = selectedDate;
                  });
                },
                readOnly: true,
                decoration: InputDecoration(
                  hintText: _eventDate == null
                      ? 'Provide your due date'
                      : DateFormat.yMMMd().format(_eventDate).toString(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _textLabel('Time of the Event'),
              TextFormField(
                onTap: () async {
                  final selectedTime = await _inputRemindTime(context);
                  setState(() {
                    _eventTime = selectedTime;
                  });
                },
                readOnly: true,
                decoration: InputDecoration(
                  hintText: _eventTime == null
                      ? 'Provide your due time'
                      : _eventTime.format(context),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                alignment: Alignment.bottomRight,
                child: OutlineButton(
                  child: Text(
                    widget.isEditMode ? 'UPDATE' : 'ADD',
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
