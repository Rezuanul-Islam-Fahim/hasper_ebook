import 'package:flutter/material.dart';
import 'package:hasper_ebook/components/book_item.dart';
import 'package:hasper_ebook/models/book.dart';
import 'package:hasper_ebook/providers/books_provider.dart';
import 'package:provider/provider.dart';

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Book?>? _libraryBooks = Provider.of<Books>(context).libraryBooks;

    return GridView(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 240,
      ),
      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
      physics: NeverScrollableScrollPhysics(),
      children: _libraryBooks!.map((Book? book) {
        return DefaultBookItem(book);
      }).toList(),
    );
  }
}
