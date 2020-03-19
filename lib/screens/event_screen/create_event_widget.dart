import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/api/event_api.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/themes/theme_color.dart';


class CreateEventWidget extends StatefulWidget {
  final String id;
  final bool isEditMode;

  CreateEventWidget({Key key, this.id, this.isEditMode}) : super(key: key);

  @override
  _CreateEventWidgetState createState() => _CreateEventWidgetState();
}

class _CreateEventWidgetState extends State<CreateEventWidget> {
  String _eventTitle;
  String _eventDescription;
  String _eventCategory = "work";
  DateTime _eventDate;
  TimeOfDay _eventTime;

  final _formKey = GlobalKey<FormState>();

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

      RemindEvent event;
      EventAPI eventAPI = new EventAPI();
      if (_eventDate != null && _eventTime != null) {
        event = new RemindEvent(
            title: _eventTitle,
            description: _eventDescription,
            category: _eventCategory,
            remindDate: DateFormat.yMMMd().format(_eventDate).toString(),
            remindTime: _eventTime.format(context).toString());
        if (event != null) {
          print(event.toJson().toString());
          eventAPI.addEvent(event);
        }
      }

//      if (!widget.isEditMode) {
//
//      } else {
//
//      }
      Navigator.of(context).pop();

    }
  }

  @override
  void initState() {
    if (widget.isEditMode) {
//      task =
//          Provider.of<TaskProvider>(context, listen: false).getById(widget.id);
//      _selectedDate = task.dueDate;
//      _selectedTime = task.dueTime;
//      _inputDescription = task.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Title', style: TextStyle(color: ThemeColor.titleColor)),
              TextFormField(
                initialValue: _eventTitle == null ? null : _eventTitle,
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
              Text('Description',
                  style: TextStyle(color: ThemeColor.titleColor)),
              TextFormField(
                initialValue:
                _eventDescription == null ? null : _eventDescription,
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
              Text('Date of the Event',
                  style: TextStyle(color: ThemeColor.titleColor)),
              TextFormField(
                onTap: () async {
                  final selectedDate = await _inputRemindDate(context);
                  setState(() {
                    _eventDate = selectedDate ;
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
              Text('Time of the Event',
                  style: TextStyle(color: ThemeColor.titleColor)),
              TextFormField(
                onTap: () async{
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
                child: FlatButton(
                  child: Text(
                    !widget.isEditMode ? 'ADD Event' : 'EDIT Event',
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
