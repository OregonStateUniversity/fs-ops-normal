import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import '../widgets/page_search_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class RedBookScreen extends StatelessWidget {
  RedBookScreen({super.key});
  static const title = "Red Book";
  static const routeName = 'redBook';
  static const pdfFileName = 'assets/RedBook2023.pdf';

  final pdfController =
      PdfController(document: PdfDocument.openAsset(pdfFileName));
  final pageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: Column(
        children: [
          Expanded(child: pdfView()),
          PageSearchBar(pageController: pageController, pdfController: pdfController, pageBuffer: 22,)
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget pdfView() => PdfView(
        controller: pdfController,
      );
}
