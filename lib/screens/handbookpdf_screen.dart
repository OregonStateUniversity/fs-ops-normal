import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';


class HandBookPdf extends StatelessWidget{
  static const routeName = 'handbook';
  static const title = "Hand Book";

  final pdfController = PdfController(document: PdfDocument.openAsset('lib/assets/RedBook.pdf'));

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: pdfView()
    );
  }
  Widget pdfView() => PdfView(
    controller: pdfController,
  );
}
