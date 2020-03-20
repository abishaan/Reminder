import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/api/event_api.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/screens/event_screen/category_widget.dart';
import 'package:reminder/widgets/empty_image_widget.dart';
import 'package:reminder/screens/event_screen/special_event_widget.dart';
import 'package:reminder/screens/event_screen/normal_event_widget.dart';
import 'package:reminder/screens/event_screen/label_widget.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  EventAPI _eventAPI = EventAPI();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        LabelWidget('Categories', 1),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CategoryWidget(Icon(Icons.work), 'Personal'),
                CategoryWidget(Icon(Icons.book), 'Study'),
                CategoryWidget(Icon(Icons.timelapse), 'Meeting'),
                CategoryWidget(Icon(Icons.work), 'Work'),
                CategoryWidget(Icon(Icons.category), 'Others'),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
        LabelWidget('Today\'s Events', 2),
        _buildEventList(context)
      ],
    );
  }

  Widget _buildEventList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _eventAPI.getEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return snapshot.data.documents.length > 0
              ? Expanded(
                  child: ListView(
                    children: snapshot.data.documents
                        .asMap()
                        .map(
                          (index, data) => MapEntry(
                            index,
                            index == 0
                                ? SpecialEventWidget(
                                    RemindEvent.fromSnapshot(data))
                                : NormalEventWidget(
                                    index, RemindEvent.fromSnapshot(data)),
                          ),
                        )
                        .values
                        .toList(),
                  ),
                )
              : EmptyImageWidget(
                  title: 'You have a free day.',
                  subtitle:
                      'Ready for some new events? Tap + to write them down.',
                  imagePath: 'assets/images/archive.png');
        });
  }
}
