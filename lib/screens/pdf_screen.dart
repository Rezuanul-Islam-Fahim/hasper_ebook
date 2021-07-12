import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatelessWidget {
  static const String routeName = '/pdf';

  @override
  Widget build(BuildContext context) {
    String? pdfUrl = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
          splashRadius: 22,
        ),
      ),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}
