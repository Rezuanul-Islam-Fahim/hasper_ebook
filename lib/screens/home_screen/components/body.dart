import 'package:flutter/material.dart';
import 'package:hasper_ebook/providers/books_provider.dart';
import 'package:hasper_ebook/screens/all_book_screen/all_book_screen.dart';
import 'package:hasper_ebook/screens/home_screen/components/recent_books.dart';
import 'package:provider/provider.dart';

import 'library.dart';

class HomeScreenBody extends StatefulWidget {
  @override
  HomeScreenBodyState createState() => HomeScreenBodyState();
}

class HomeScreenBodyState extends State<HomeScreenBody> {
  bool? _isinit = false;
  bool? _isLoading = true;

  Future<void> loadBooks() async {
    await Provider.of<Books>(context, listen: false).loadRecentBooks();
    await Provider.of<Books>(context, listen: false).loadLibraryBooks();
    setState(() => _isLoading = false);
  }

  @override
  void didChangeDependencies() {
    if (!_isinit!) {
      loadBooks();
      _isinit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading!
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Recently Uploaded',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(height: 15),
                RecentBooks(),
                SizedBox(height: 25),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Library',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      child: Text('See All Books'),
                      onPressed: () => Navigator.of(context).pushNamed(
                        AllBookScreen.routeName,
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                Library(),
              ],
            ),
          );
  }
}
