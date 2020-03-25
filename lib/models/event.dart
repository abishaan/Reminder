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

  RemindEvent.fromMap(Map<String, dynamic> map, {this.reference})
      : category = map['category'] ?? '',
        description = map['description'] ?? '',
        remindDate = map['remindDate'] ?? '',
        remindTime = map['remindTime'] ?? '',
        timestamp = map['timestamp'] ?? 0;

  RemindEvent.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

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
    return category + '-' + description + '-' + remindTime;
  }
}
