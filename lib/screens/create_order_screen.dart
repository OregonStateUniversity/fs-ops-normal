import 'package:flutter/material.dart';
import 'package:hose_jockey/screens/engagement_screen.dart';
import 'package:hose_jockey/time_format.dart';
import 'modify_estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import 'engagement_screen.dart';

class CreateOrderScreen extends StatelessWidget {
  const CreateOrderScreen({Key? key}) : super(key: key);

  static const routeName = 'createOrderScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Order Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, SelectedEngagement.routeName);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
