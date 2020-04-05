import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder/utils/theme_color.dart';

class RemindEvent {
  final String category;
  final String description;
  final String remindDate;
  final String remindTime;
  final int timestamp;
  final int categoryColor;

  String id;
  DocumentReference reference;

  RemindEvent(
      {this.id,
      this.category,
      this.description,
      this.remindDate,
      this.remindTime,
      this.reference,
      this.timestamp,
      this.categoryColor});

  RemindEvent.fromSnapshot(DocumentSnapshot snapshot)
      : reference = snapshot.reference,
        category = snapshot.data['category'] ?? '',
        description = snapshot.data['description'] ?? '',
        remindDate = snapshot.data['remindDate'] ?? '',
        remindTime = snapshot.data['remindTime'] ?? '',
        timestamp = snapshot.data['timestamp'] ?? 0,
        categoryColor = snapshot.data['categoryColor'] ?? ThemeColor.primaryAccent.value;

  toJson() => {
        'category': category,
        'categoryColor': categoryColor,
        'description': description,
        'remindDate': remindDate,
        'remindTime': remindTime,
        'timestamp': timestamp
      };

  @override
  String toString() {
    return reference.documentID +
        '^' +
        category +
        '^' +
        categoryColor.toString() +
        '^' +
        description +
        '^' +
        remindTime +
        '^' +
        remindDate;
  }
}
