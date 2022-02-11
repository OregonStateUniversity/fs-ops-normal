import 'package:flutter/material.dart';
import 'package:hose_jockey/time_format.dart';
import 'modify_estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';

class CreateOrderScreen extends StatelessWidget {
  const CreateOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Order Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first screen when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
