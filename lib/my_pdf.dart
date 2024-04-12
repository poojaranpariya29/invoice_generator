import 'package:flutter/material.dart';
import 'package:invoice_generator/pdf.dart';

class MyPdf extends StatefulWidget {
  const MyPdf({super.key});

  @override
  State<MyPdf> createState() => _MyPdfState();
}

class _MyPdfState extends State<MyPdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: PdfData().getPdfPreview(),
    );
  }
}
