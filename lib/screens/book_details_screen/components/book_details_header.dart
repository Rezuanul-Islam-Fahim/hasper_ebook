import 'package:flutter/material.dart';
import 'package:hasper_ebook/models/book.dart';
import 'package:hasper_ebook/styles.dart';

class BookDetailsHeader extends StatelessWidget {
  const BookDetailsHeader({
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 450,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(book.coverPhotoUrl!),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Color(0xFF6d4587).withOpacity(0.85),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 175,
              decoration: BoxDecoration(
                color: Color(0xFF6d4587).withOpacity(0.85),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[800]!,
                    offset: Offset(1, 2),
                    blurRadius: 3,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  book.coverPhotoUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.12,
              ),
              child: Text(
                book.title!,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Color(0xFF6a418a).withOpacity(0.7),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDataPanel(book.pages!.toString(), 'Number Of Pages'),
                  _buildDataPanel(book.language!, 'Language'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataPanel(String title, String value) {
    return Column(
      children: [
        Text(title, style: dataPanelTitle()),
        SizedBox(height: 10),
        Text(value, style: dataPanelValue()),
      ],
    );
  }
}
