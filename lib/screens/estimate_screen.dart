import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Widgets/ru_bottom_nav_bar.dart';
import '../models/estimate.dart';

class EstimateScreen extends StatelessWidget{

  static const routeName = 'estimateScreen';

  @override
  Widget build(BuildContext context) {

    final Estimate estimate = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Copy Your Order"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: SelectableText(
                    estimate.toCopyString()
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: floatingActionButton(estimate, context),
      bottomNavigationBar: RU_BottomNavBar(goBack: 'engagement')
    );
  }

  Widget floatingActionButton(estimate, context){
    return FloatingActionButton(
      child: Icon(Icons.copy),
        onPressed: (){
      Clipboard.setData(
              ClipboardData(text: estimate.toCopyString())
          )
                .then((value)
            => ScaffoldMessenger.of(context)
                .showSnackBar(
                const SnackBar(content: Text("Copied to Clipboard"),)
            )
            );
          }
      );
  }

  Widget floatAccButton(estimate, context){
    return FloatingActionButton.extended(
        onPressed: (){
          Clipboard.setData(
              ClipboardData(text: estimate.toCopyString())
            )
            .then((value) 
              => ScaffoldMessenger.of(context)
              .showSnackBar(
                const SnackBar(content: Text("Copied to Clipboard"),)
              )
            );
        },
        icon: Icon(Icons.copy),
        label: Text("Copy"),
      );
  }

}
