import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import '../widgets/bottom_nav_bar.dart';

class IncidentResponsePocketGuideScreen extends StatelessWidget {
  static const title = "Pocket Guide";
  static const PDF_FILE_NAME = 'lib/assets/IRPG_2018.pdf';

  final pdfController =
      PdfController(document: PdfDocument.openAsset(PDF_FILE_NAME));
  final pageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Expanded(child: pdfView()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: ElevatedButton(
                    child: Text("Go To"),
                    onPressed: () {
                      pdfController
                          .jumpToPage(int.parse(pageController.text) + 16);
                      FocusScope.of(context).unfocus();
                      pageController.clear();
                    }),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                    controller: pageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Page Number"),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(goBack: '/'),
    );
  }

  Widget pdfView() => PdfView(
        controller: pdfController,
      );
}
