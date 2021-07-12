import 'package:flutter/foundation.dart';
import 'package:hasper_ebook/models/book.dart';
import 'package:hasper_ebook/repositories/db_repository.dart';

class Books with ChangeNotifier {
  List<Book?>? _recentBooks = [];
  List<Book?>? _libraryBooks = [];

  List<Book?>? get recentBooks {
    return [..._recentBooks!];
  }

  List<Book?>? get libraryBooks {
    return [..._libraryBooks!];
  }

  Future<void> loadRecentBooks() async {
    List<Book>? _loadedBooks = await DBRepository.fetchBooks(
      orderBy: 'dateTime',
      desc: true,
      limit: 6,
    );
    _recentBooks = _loadedBooks;
    notifyListeners();
  }

  Future<void> loadLibraryBooks() async {
    List<Book>? _loadedBooks = await DBRepository.fetchBooks(limit: 10);
    _libraryBooks = _loadedBooks;
    notifyListeners();
  }

  Future<Book?>? fetchById(String id) async {
    return DBRepository.findById(id);
  }
}
