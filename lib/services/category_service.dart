import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reminder/models/category.dart';
import 'package:reminder/utils/constants.dart';

class CategoryService {
  final CollectionReference _collectionReference = Firestore.instance
      .collection(Constants.userCollection)
      .document(Constants.uid)
      .collection(Constants.categoryCollection);

  Stream<List<Category>> getAllCategories() {
    return _collectionReference.snapshots().map(_categoryListFormSnapshot);
  }

  List<Category> _categoryListFormSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map(
          (document) => Category(
            reference: document.reference,
            color: document.data['color'] ?? '',
            iconCodePoint: document.data['iconCodePoint'] ?? '',
            name: document.data['name'] ?? '',
          ),
        )
        .toList();
  }

  addCategory(Category category) async {
    try {
      await _collectionReference.document().setData(category.toJson());
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  updateCategory(Category category) async {
    try {
      await _collectionReference
          .document(category.reference.documentID)
          .updateData(category.toJson());
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  deleteCategory(DocumentReference reference) async {
    try {
      await _collectionReference.document(reference.documentID).delete();
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
