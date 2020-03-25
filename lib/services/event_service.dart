import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/utils/constants.dart';

class EventService {
  final CollectionReference _collectionReference = Firestore.instance
      .collection(Constants.userCollection)
      .document(Constants.uid)
      .collection(Constants.eventCollection);

  Stream<List<RemindEvent>> getAllEvents() {
    return _collectionReference.snapshots().map(_eventListFormSnapshot);
  }

  Stream<QuerySnapshot> getCurrentEventSnapshots() {
    return _collectionReference
        .where('remindDate',
            isEqualTo: DateFormat("yyyy-MM-dd")
                .parse(DateTime.now().toString())
                .toString()).orderBy('timestamp')
        .snapshots();
  }

  List<RemindEvent> _eventListFormSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((document) => RemindEvent(
            category: document.data['category'] ?? '',
            description: document.data['description'] ?? '',
            remindDate: document.data['remindDate'] ?? '',
            remindTime: document.data['remindTime'] ?? ''))
        .toList();
  }

  addEvent(RemindEvent event) {
    try {
      Firestore.instance.runTransaction((Transaction transaction) async {
        await _collectionReference.document().setData(event.toJson());
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

  deleteEvent(DocumentReference reference) {
    Firestore.instance.runTransaction((transaction) async {
      await transaction.delete(reference);
    });
  }
}
