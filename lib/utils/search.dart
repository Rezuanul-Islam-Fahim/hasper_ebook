import 'package:flutter/material.dart';
import 'package:hasper_ebook/models/book.dart';
import 'package:hasper_ebook/repositories/db_repository.dart';
import 'package:hasper_ebook/screens/book_details_screen/book_details_screen.dart';
import 'package:hasper_ebook/styles.dart';

class Search extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(color: Colors.white),
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF1d212b),
        brightness: Brightness.dark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white70),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        iconSize: 16,
        color: Colors.white,
        splashRadius: 10,
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
      splashRadius: 22,
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: DBRepository.searchBooksByKeyword(query.toLowerCase().trim()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return (snapshot.data as List<Book>).isNotEmpty
            ? ListView(
                children: (snapshot.data as List<Book>)
                    .map((Book book) => SearchBookItem(book))
                    .toList(),
              )
            : Center(
                child: Text(
                  query.isEmpty
                      ? 'Search For Specific Books'
                      : 'No results found for this entry',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(
        'Search For Specific Books',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

class SearchBookItem extends StatelessWidget {
  const SearchBookItem(this.book);

  final Book? book;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        BookDetailsScreen.routeName,
        arguments: book,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(book!.coverPhotoUrl!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Text(
                  book!.title!,
                  style: searchBookItem(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
