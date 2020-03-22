import 'package:cloud_firestore/cloud_firestore.dart';

class RemindEvent {
  final String title;
  final String description;
  final String category;
  final String remindDate;
  final String remindTime;

  DocumentReference reference;

  RemindEvent(
      {this.title,
      this.description,
      this.category,
      this.remindDate,
      this.remindTime,
      this.reference});

  RemindEvent.fromMap(Map<String, dynamic> map, {this.reference})
      : title = map['title'],
        description = map['description'],
        category = map['category'],
        remindDate = map['remindDate'],
        remindTime = map['remindTime'];

  RemindEvent.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'remindDate': remindDate,
      'remindTime': remindTime
    };
  }

  @override
  String toString() {
    return title +
        '-' +
        description +
        '-' +
        category +
        '-' +
        remindTime;
  }
}
