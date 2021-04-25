import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import '../Widgets/ru_bottom_nav_bar.dart';

class HandBookPdf extends StatelessWidget{
  static const routeName = 'handbook';
  static const title = "Red Book PDF";

  final pdfController = PdfController(document: PdfDocument.openAsset('lib/assets/RedBook.pdf'));

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: pdfView(),
      bottomNavigationBar: RU_BottomNavBar(goBack: '/',),
    );
  }
  Widget pdfView() => PdfView(
    controller: pdfController,
  );
}
