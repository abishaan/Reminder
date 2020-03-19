import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder/models/event.dart';

class EventAPI {
  final String eventCollection = 'Events';

  getEvents() {
    return Firestore.instance.collection(eventCollection).snapshots();
  }

  addEvent(RemindEvent event) {
    try {
      Firestore.instance.runTransaction((Transaction transaction) async {
        await Firestore.instance
            .collection(eventCollection)
            .document()
            .setData(event.toJson());
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  updateEvent(RemindEvent event) {
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(event.reference, event.toJson());
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  deleteEvent(RemindEvent event) {
    Firestore.instance.runTransaction((transaction) async {
      await transaction.delete(event.reference);
    });
  }
}

