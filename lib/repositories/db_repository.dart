import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hasper_ebook/models/book.dart';

class DBRepository {
  static Future<List<Book>?> fetchBooks({
    String? orderBy,
    bool? desc,
    int? limit,
  }) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>>? _querySnapshot;

    if (orderBy == null && limit != null) {
      _querySnapshot = await _fireStore.collection('books').limit(limit).get();
    } else if (orderBy != null && desc != null && limit != null) {
      _querySnapshot = await _fireStore
          .collection('books')
          .orderBy(orderBy, descending: desc)
          .limit(limit)
          .get();
    }

    List<QueryDocumentSnapshot> _docs = _querySnapshot!.docs;
    List<Book> _recentBooks = _docs.map((QueryDocumentSnapshot doc) {
      return Book.fromFirestore(doc);
    }).toList();

    return _recentBooks;
  }

  static Future<List<Book>> fetchBooksFromRange({
    int? offset,
    int? limit,
  }) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>>? _querySnapshot =
        await _fireStore.collection('books').orderBy('title').get();
    List<QueryDocumentSnapshot> _loadedItems = _querySnapshot.docs;
    List<Book>? _filteredBooks = [];
    int _lastIndex = offset! + limit! > _loadedItems.length
        ? _loadedItems.length
        : offset + limit;

    for (int i = offset; i < _lastIndex; i++) {
      _filteredBooks.add(
        Book.fromFirestore(_loadedItems[i]),
      );
    }

    return _filteredBooks;
  }

  static Future<Book?>? findById(String? id) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    DocumentReference _reference = _fireStore.collection('books').doc(id);
    DocumentSnapshot _snapshot = await _reference.get();

    return Book.fromFirestore(_snapshot);
  }

  static Future<List<Book>?>? searchBooksByKeyword(String? keyword) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> _querySnapshot =
        await _fireStore.collection('books').get();
    List<QueryDocumentSnapshot> _documentSnapshot = _querySnapshot.docs;
    List<Book> _loadedBooks =
        _documentSnapshot.map((QueryDocumentSnapshot snapshot) {
      return Book.fromFirestore(snapshot);
    }).toList();

    return keyword!.isNotEmpty
        ? _loadedBooks
            .where((Book book) => book.title!.toLowerCase().contains(keyword))
            .toList()
        : [];
  }
}
