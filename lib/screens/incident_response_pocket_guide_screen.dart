import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import '../widgets/bottom_nav_bar.dart';

class IncidentResponsePocketGuideScreen extends StatelessWidget {
  static const routeName = 'pocketGuide';
  static const title = "Pocket Guide";
  static const pdfFileName = 'assets/IRPG_2022.pdf';

  final pdfController =
      PdfController(document: PdfDocument.openAsset(pdfFileName));
  final pageController = TextEditingController();

  IncidentResponsePocketGuideScreen({super.key});
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
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                    child: const Text("Go To"),
                    onPressed: () {
                      pdfController
                          .jumpToPage(int.parse(pageController.text) + 16);
                      FocusScope.of(context).unfocus();
                      pageController.clear();
                    }),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: pageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Page Number"),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: const BottomNavBar(goBack: '/'),
    );
  }

  Widget pdfView() => PdfView(
        controller: pdfController,
      );
}
