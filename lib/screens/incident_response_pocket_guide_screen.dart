import 'package:flutter/material.dart';
import 'package:ops_normal/screens/compass_screen.dart';
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
        title: const Text(title),
      ),
      body: Column(
        children: [
          const PdfViewer(),
          Expanded(child: pdfView()),
          PageSearchBar(pageController: pageController, pdfController: pdfController)
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget pdfView() => PdfView(
        controller: pdfController,
      );
}

// widget that displays pdf that is swipeable
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

// widget containing search bar and button to go to required page
class PageSearchBar extends StatelessWidget {
  const PageSearchBar({
    super.key,
    required this.pageController,
    required this.pdfController,
  });

  final TextEditingController pageController;
  final PdfController pdfController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: GoToButton(pageController: pageController, pdfController: pdfController),
        ),
        SearchEntry(pageController: pageController)
      ],
    );
  }
}

// widget to enter desired page number to be searched
class SearchEntry extends StatelessWidget {
  const SearchEntry({
    super.key,
    required this.pageController,
  });

  final TextEditingController pageController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}

// button clicked to go to desired page
class GoToButton extends StatelessWidget {
  const GoToButton({
    super.key,
    required this.pageController,
    required this.pdfController,
  });

  final TextEditingController pageController;
  final PdfController pdfController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: const Text("Go To"),
        onPressed: () {
          pageController.text == "" ? pageController.clear():
            pdfController
                .jumpToPage(int.parse(pageController.text) + 16);
            FocusScope.of(context).unfocus();
            pageController.clear();
        }
      );
  }

}
