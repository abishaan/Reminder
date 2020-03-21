import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reminder/api/event_api.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/screens/event_screen/event_list_widget.dart';
import 'package:reminder/themes/theme_color.dart';
import 'package:reminder/widgets/empty_image_widget.dart';

class EventScreen extends StatelessWidget {
  final EventAPI _eventAPI = EventAPI();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _buildEventList(context),
      ),
    );
  }

  Widget _upperView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
              child: Text(
                'Hey Peter,',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: ThemeColor.primaryAccent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: IconButton(
                icon: Icon(
                  MdiIcons.logout,
                  color: ThemeColor.darkAccent,
                  size: 25,
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
          child: Text(
            'what\'s your plan today?',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: ThemeColor.primaryAccent),
          ),
        ),
      ],
    );
  }

  Widget _buildEventList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _eventAPI.getEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return snapshot.data.documents.length > 0
              ? ListView(
                  children: snapshot.data.documents
                      .asMap()
                      .map(
                        (index, data) => MapEntry(
                          index,
                          index == 0
                              ? _upperView()
                              : EventListWidget(
                                  index, RemindEvent.fromSnapshot(data)),
                        ),
                      )
                      .values
                      .toList(),
                )
              : ListView(
                  children: <Widget>[
                    _upperView(),
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
