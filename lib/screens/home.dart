import 'package:dev_odyssey/providers/auth_provider.dart';
import 'package:dev_odyssey/routes.dart';
import 'package:dev_odyssey/widgets/BottomNavBar.dart';
import 'package:dev_odyssey/widgets/restart_app.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              print("${authProvider.status}");
            },
            child: const Text("status")),
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
          onPressed: () {
            authProvider.signOut();
            Navigator.of(context).pushReplacementNamed(Routes.login);
            RestartWidget.restartApp(context);
          },
        ),
      ),
    );
  }
}
