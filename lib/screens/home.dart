import 'package:dev_odyssey/providers/auth_provider.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../widgets/BottomNavBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dev Odyssey',
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: const Center(
        child: Text("Home page."),
      ),
      bottomNavigationBar: const BottomNavBar(
          left: "friends",
          middle: "odyssey",
          right: "explore",
          leftIcon: FontAwesomeIcons.userFriends,
          middleIcon: FontAwesomeIcons.ship,
          rightIcon: FontAwesomeIcons.map),
      drawer: Drawer(
        backgroundColor: Colors.redAccent,
        child: IconButton(
          icon: const Icon(FontAwesomeIcons.signOutAlt),
          onPressed: () => authProvider.signOut(),
        ),
      ),
    );
  }
}