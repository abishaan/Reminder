import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/services/event_service.dart';

class EventProvider extends ChangeNotifier {
  Map<DateTime, List<String>> mapList = Map();
  List<RemindEvent> eventList = List();
  HashSet<String> dates = HashSet();

  Future<void> getCalendarEvents() async {
    try {
      final QuerySnapshot snapshot =
          await EventService().getAllEventDocuments();
      List<DocumentSnapshot> documents = snapshot.documents;

      await Future.delayed(Duration(seconds: 0), () {
        documents.forEach((data) {
          RemindEvent event = RemindEvent.fromSnapshot(data);
          eventList.add(event);
          dates.add(event.remindDate);
        });
      });

      await Future.delayed(Duration(seconds: 0), () {
        dates.forEach((date) {
          mapList[DateTime.parse(date)] = _filterEvent(date) ?? [];
        });
      });

      if (mapList != null) print('Data fetched successfully...');
      notifyListeners();
    } catch (e) {
      print('Can\'t get data from Firestore' + e.toString());
    }
  }

  List<String> _filterEvent(String date) {
    List<RemindEvent> tempEventList =
        eventList.where((i) => i.remindDate == date).toList();
    List<String> filteredList = List();
    tempEventList.forEach((event) => filteredList.add(event.toString()));
    return filteredList;
  }
}
