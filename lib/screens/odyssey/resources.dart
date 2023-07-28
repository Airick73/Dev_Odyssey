import 'package:flutter/material.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to the resouces screen"),
      ),
      body: const Center(
        child: Text("Resources screen"),
      ),
    );
  }
}
