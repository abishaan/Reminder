import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final int color;
  final int iconCodePoint;
  final String name;

  DocumentReference reference;

  Category({this.color, this.iconCodePoint, this.name, this.reference});

  toJson() => {"color": color, "iconCodePoint": iconCodePoint, "name": name};
}
