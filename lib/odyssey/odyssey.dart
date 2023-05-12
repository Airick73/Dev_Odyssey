import 'package:flutter/material.dart';

class OdysseyScreen extends StatelessWidget {
  const OdysseyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Odyssey"),
      ),
      body: const Center(
        child: Text("Odyssey Screen"),
      ),
    );
  }
}
