import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/screens/event_screen/event_card.dart';
import 'package:reminder/screens/event_screen/profile_label.dart';
import 'package:reminder/services/event_service.dart';
import 'package:reminder/shared/empty_image_widget.dart';

class EventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: EventService().getEventsByDate(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return snapshot.data.documents.length > 0
              ? ListView(
                  children: <Widget>[
                    ProfileLabel(),
                    Column(
                      children: snapshot.data.documents
                          .asMap()
                          .map(
                            (index, data) => MapEntry(
                              index,
                              EventCard(
                                index: index,
                                remindEvent: RemindEvent.fromSnapshot(data),
                              ),
                            ),
                          )
                          .values
                          .toList(),
                    ),
                  ],
                )
              : ListView(
                  children: <Widget>[
                    ProfileLabel(),
                    EmptyImageWidget(
                        title: 'You have a free day.',
                        subtitle:
                            'Ready for some new events? Tap + to write them down.',
                        imagePath: 'assets/images/archive.png'),
                  ],
                );
        });
  }
}
