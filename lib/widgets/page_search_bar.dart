import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

// widget containing search bar and button to go to required page
class PageSearchBar extends StatelessWidget {
  const PageSearchBar({
    super.key,
    required this.pageController,
    required this.pdfController,
    required this.pageBuffer,
  });

  final TextEditingController pageController;
  final PdfController pdfController;
  final int pageBuffer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: SearchButton(
            pageController: pageController, 
            pdfController: pdfController, 
            pageBuffer: pageBuffer)
        ),
        SearchEntry(pageController: pageController)
      ],
    );
  }
}

// widget for button clicked to initiate page search
class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
    required this.pageController,
    required this.pdfController,
    required this.pageBuffer,
  });

  final TextEditingController pageController;
  final PdfController pdfController;
  final int pageBuffer;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text("Go To"),
      onPressed: () {
        pageController.text == "" ? pageController.clear():
          pdfController.jumpToPage(int.parse(pageController.text) + pageBuffer);
        FocusScope.of(context).unfocus();
        pageController.clear();
      }
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