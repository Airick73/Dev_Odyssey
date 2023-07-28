import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About"),
          backgroundColor: Colors.greenAccent,
        ),
        body: Center(
          child: Text("Welcome to the about screen"),
        ));
  }
}
