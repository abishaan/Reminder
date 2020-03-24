import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/screens/event_screen/event_list.dart';
import 'package:reminder/services/event_service.dart';

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: EventService().getEventsByDate(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: EventList(),
        ),
      ),
    );
  }
}
