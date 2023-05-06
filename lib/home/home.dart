import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dev Odyssey',
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Text("Home page"),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.userFriends),
          label: 'Friends',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.ship),
          label: 'Odyssey',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.map),
          label: 'Explore',
        )
      ]),
      drawer: Drawer(
        backgroundColor: Colors.redAccent,
        child: ListView.builder(
          addAutomaticKeepAlives: false,
          itemBuilder: (_, idx) {
            return Container(
              color: RandomColor(),
              width: 500,
              height: 500,
            );
          },
        ),
      ),
    );
  }
}

Color RandomColor() {
  final Color color;
  final int r;
  final int g;
  final int b;
  final int a;
  a = Random().nextInt(255);
  r = Random().nextInt(255);
  g = Random().nextInt(255);
  b = Random().nextInt(255);
  color = Color.fromARGB(a, r, g, b);
  return color;
}
