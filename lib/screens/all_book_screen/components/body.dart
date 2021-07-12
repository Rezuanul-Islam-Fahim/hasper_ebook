import 'package:flutter/material.dart';
import 'package:hasper_ebook/components/book_item.dart';
import 'package:hasper_ebook/models/book.dart';
import 'package:hasper_ebook/repositories/db_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AllBookScreenBody extends StatefulWidget {
  @override
  _AllBookScreenBodyState createState() => _AllBookScreenBodyState();
}

class _AllBookScreenBodyState extends State<AllBookScreenBody> {
  final int _pageSize = 20;
  final PagingController<int, Book> _pagingController = PagingController(
    firstPageKey: 0,
  );

  Future<void>? fetchItems(int pageKey) async {
    try {
      List<Book> _loadedBooks = await DBRepository.fetchBooksFromRange(
        offset: pageKey,
        limit: _pageSize,
      );
      bool _isLastPage = _loadedBooks.length < _pageSize;

      if (_isLastPage) {
        _pagingController.appendLastPage(_loadedBooks);
      } else {
        final int _newPageKey = pageKey + _pageSize;
        _pagingController.appendPage(_loadedBooks, _newPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((int pageKey) {
      fetchItems(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedGridView(
      pagingController: _pagingController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 240,
      ),
      padding: EdgeInsets.all(15),
      builderDelegate: PagedChildBuilderDelegate<Book>(
        itemBuilder: (ctx, book, index) {
          return DefaultBookItem(book);
        },
      ),
    );
  }
}
