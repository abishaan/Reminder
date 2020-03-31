import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/themes/theme_color.dart';
import 'package:reminder/utils/constants.dart';

class EventService {
  final CollectionReference _collectionReference = Firestore.instance
      .collection(Constants.userCollection)
      .document(Constants.uid)
      .collection(Constants.eventCollection);

  Stream<List<RemindEvent>> getAllEvents() {
    return _collectionReference
        .orderBy('timestamp')
        .snapshots()
        .map(_eventListFormSnapshot);
  }

  Future<QuerySnapshot> getAllEventsByCategory(String category) async {
    return _collectionReference
        .where('category', isEqualTo: category)
        .getDocuments();
  }

  Stream<QuerySnapshot> getCurrentEventSnapshots() {
    return _collectionReference
        .where('remindDate',
            isEqualTo: DateFormat("yyyy-MM-dd")
                .parse(DateTime.now().toString())
                .toString())
        .orderBy('timestamp')
        .snapshots();
  }

  List<RemindEvent> _eventListFormSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map(
          (document) => RemindEvent(
              reference: document.reference,
              category: document.data['category'] ?? '',
              categoryColor: document.data['categoryColor'] ??
                  ThemeColor.primaryAccent.value,
              description: document.data['description'] ?? '',
              remindDate: document.data['remindDate'] ?? '',
              remindTime: document.data['remindTime'] ?? ''),
        )
        .toList();
  }

  addEvent(RemindEvent event) async {
    try {
      await _collectionReference.document().setData(event.toJson());
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  updateEvent(RemindEvent event) async {
    String id = event.reference != null ? event.reference.documentID : event.id;
    try {
      await _collectionReference.document(id).updateData(event.toJson());
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  deleteEvent(DocumentReference reference) async {
    try {
      await _collectionReference.document(reference.documentID).delete();
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  deleteEventById(String id) async {
    try {
      await _collectionReference.document(id).delete();
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  checkEventsByCategory(String category) async {
    try {
      QuerySnapshot snapshot = await getAllEventsByCategory(category);
      List<RemindEvent> events = _eventListFormSnapshot(snapshot);

      if (events.isNotEmpty) {
        return true;
      }

      return false;
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  deleteEventsByCategory(String category) async {
    try {
      QuerySnapshot snapshot = await getAllEventsByCategory(category);
      snapshot.documents.forEach(
          (document) async => await deleteEventById(document.documentID));
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
