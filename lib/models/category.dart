import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Category {
  final Color color;
  final IconData icon;
  final String name;

  DocumentReference reference;

  Category({this.color, this.icon, this.name, this.reference});

  toJson() => {"color": color, "icon": icon, "name": name};
}
