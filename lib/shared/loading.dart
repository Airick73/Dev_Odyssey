import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'assets/gifs/barco.gif',
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/gifs/barco.gif',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
