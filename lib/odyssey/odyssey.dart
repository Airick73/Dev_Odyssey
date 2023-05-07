import 'package:dev_odyssey/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OdysseyScreen extends StatelessWidget {
  const OdysseyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Odyssey"),
      ),
      body: Center(
        child: Text("Odyssey Screen"),
      ),
    );
  }
}
