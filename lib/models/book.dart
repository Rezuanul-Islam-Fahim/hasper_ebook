import 'package:flutter/foundation.dart';

class Book {
  Book({
    @required this.id,
    @required this.title,
    @required this.pdfUrl,
    @required this.coverPhotoUrl,
    @required this.language,
    @required this.pages,
    @required this.description,
    @required this.dateTime,
  });

  final String? id;
  final String? title;
  final String? pdfUrl;
  final String? coverPhotoUrl;
  final String? language;
  final int? pages;
  final String? description;
  final DateTime? dateTime;

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      pdfUrl: map['pdfUrl'],
      coverPhotoUrl: map['coverPhotoUrl'],
      language: map['language'],
      pages: map['pages'],
      description: map['description'],
      dateTime: map['dateTime'],
    );
  }

  factory Book.fromFirestore(dynamic book) {
    return Book(
      id: book.id,
      title: book.get('title'),
      coverPhotoUrl: book.get('coverPhotoUrl'),
      language: book.get('language'),
      pdfUrl: book.get('pdfUrl'),
      pages: book.get('pages'),
      description: book.get('description'),
      dateTime: DateTime.parse(book.get('dateTime')),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'pdfUrl': pdfUrl,
      'coverPhotoUrl': coverPhotoUrl,
      'language': language,
      'pages': pages,
      'description': description,
      'dateTime': dateTime!.toIso8601String(),
    };
  }
}
