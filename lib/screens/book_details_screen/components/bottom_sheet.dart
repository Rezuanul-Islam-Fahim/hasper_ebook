import 'package:flutter/material.dart';
import 'package:hasper_ebook/screens/pdf_screen.dart';

class BookBottomSheet extends StatelessWidget {
  const BookBottomSheet(this.pdfUrl);

  final String? pdfUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            offset: Offset(0, -1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text(
                'Start Reading',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 13),
              ),
              onPressed: () => Navigator.of(context).pushNamed(
                PDFScreen.routeName,
                arguments: pdfUrl!,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
