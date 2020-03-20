import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder/models/event.dart';

class CategoryAPI {
  final String eventCollection = 'Categories';

  getEvents() {
    return Firestore.instance.collection(eventCollection).snapshots();
  }

  getEventsByDate(String category) {
    return Firestore.instance
        .collection(eventCollection)
        .orderBy('category')
        .where('category', isEqualTo: category)
        .snapshots();
  }

  addCategory(RemindEvent event) {
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

  updateCategory(RemindEvent event) {
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(event.reference, event.toJson());
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  deleteCategory(DocumentReference reference) {
    Firestore.instance.runTransaction((transaction) async {
      await transaction.delete(reference);
    });
  }
}
