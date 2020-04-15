import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/screens/event_screen/event_card.dart';
import 'package:reminder/screens/event_screen/profile_label.dart';
import 'package:reminder/services/event_service.dart';
import 'package:reminder/shared/empty_image_widget.dart';

class EventScreen extends StatelessWidget {
  Widget _emptyWidget() {
    return ListView(
      children: <Widget>[
        ProfileLabel(),
        SizedBox(
          height: 20,
        ),
        EmptyImageWidget(
            title: 'You have a free day.',
            subtitle: 'Ready for some new events? Tap + to write them down.',
            imagePath: 'assets/images/plan.png'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
            stream: EventService().getCurrentEventSnapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return _emptyWidget();
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
                  : _emptyWidget();
            }),
      ),
    );
  }
}
