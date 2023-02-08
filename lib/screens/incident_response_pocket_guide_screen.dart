import 'package:flutter/material.dart';
import 'package:ops_normal/screens/compass_screen.dart';
import 'package:pdfx/pdfx.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/page_search_bar.dart';

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
        title: const Text(title),
      ),
      body: Column(
        children: [
          const PdfViewer(),
          Expanded(child: pdfView()),
          PageSearchBar(pageController: pageController, pdfController: pdfController, pageBuffer: 16,)
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget pdfView() => PdfView(
        controller: pdfController,
      );
}

// widget that displays pdf that is swipeable and compass image
class PdfViewer extends StatelessWidget {
  const PdfViewer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CompassScreen()));
          },
          child: Image.asset('assets/images/compass_image.png')
        ),
    );
  }
}
