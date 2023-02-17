import 'package:flutter/material.dart';
import '../utils/how_to_instructions_strings.dart';
import '../widgets/bottom_nav_bar.dart';

enum ListStyle { numeric, alphabet }

class HowToScreen extends StatelessWidget {
  static const routeName = 'howto';
  static const title = "How To Use Ops Normal";
  static const TextAlign align = TextAlign.center;
  const HowToScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: Semantics(
          label: "A list of instructions about how to use Ops Normal",
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: FractionalOffset.center,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      buildInstructions(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar());
  }

  Widget _cardItem(String title, description) {
    return Semantics(
        readOnly: false,
        label: "Dropdown description for how to use Ops Normal",
        child: Card(
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20.0, right: 20.0, bottom: 10.0),
              child: ExpansionTile(
                title: Text(title),
                children: [description],
              )),
        ));
  }

  Widget buildInstructions() {
    return Column(
        children: instructionList
            .map((instruction) => _cardItem(
                instruction['title'],
                OrderedList(
                    listItems: instruction['description'],
                    listStyle: ListStyle.numeric)))
            .toList());
  }
}

class OrderedList extends StatelessWidget {
  const OrderedList(
      {super.key,
      required this.listItems,
      required this.listStyle,
      this.listNestedOrder = 0});
  final ListStyle listStyle;
  final List listItems;
  final int listNestedOrder;
  @override
  Widget build(BuildContext context) {
    if (listStyle == ListStyle.numeric) {
      return _buildNumericList();
    } else {
      return _buildAlphabetList(listItems, listNestedOrder);
    }
  }

  Widget _buildNumericList() {
    List<Widget> children = [];
    int numericCounter = 1;
    for (var i = 0; i < listItems.length; i++) {
      if (listItems[i].runtimeType == List<String>) {
        children.add(_buildAlphabetList(listItems[i], 1));
        children.add(const SizedBox(
          height: 20,
        ));
        continue;
      }
      children.add(
          itemRow(ith: Text(numericCounter.toString()), item: listItems[i]));
      numericCounter++;
    }
    return Container(
      margin: EdgeInsets.only(left: (listNestedOrder * 30)),
      child: Column(children: children),
    );
  }

  Widget itemRow({
    ith,
    item,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ith,
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(item.toString()),
          ),
        ],
      ),
    );
  }

  Widget _buildAlphabetList(listItems, int listNestedOrder) {
    debugPrint(listItems.toString());
    return Container(
      margin: EdgeInsets.only(left: (listNestedOrder * 30)),
      child: Column(children: [
        for (var i = 0; i < listItems.length; i++)
          itemRow(ith: Text(String.fromCharCode(i + 65)), item: listItems[i])
      ]),
    );
  }
}
