import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewingScreen extends StatelessWidget {
  const PdfViewingScreen({super.key, required this.file});
  static String route = '/pdf_view';
  final String file;
  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.file(
      File(file),
    );
  }
}
