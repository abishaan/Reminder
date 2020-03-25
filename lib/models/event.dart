import 'package:cloud_firestore/cloud_firestore.dart';

class RemindEvent {
  final String category;
  final String description;
  final String remindDate;
  final String remindTime;
  final int timestamp;

  DocumentReference reference;

  RemindEvent(
      {this.category,
      this.description,
      this.remindDate,
      this.remindTime,
      this.reference,
      this.timestamp});

  RemindEvent.fromSnapshot(DocumentSnapshot snapshot)
      : reference = snapshot.reference,
        category = snapshot.data['category'] ?? '',
        description = snapshot.data['description'] ?? '',
        remindDate = snapshot.data['remindDate'] ?? '',
        remindTime = snapshot.data['remindTime'] ?? '',
        timestamp = snapshot.data['timestamp'] ?? 0;

  toJson() {
    return {
      'category': category,
      'description': description,
      'remindDate': remindDate,
      'remindTime': remindTime,
      'timestamp': timestamp
    };
  }

  @override
  String toString() {
    return reference.documentID +
        '-' +
        category +
        '-' +
        description +
        '-' +
        remindTime;
  }
}
