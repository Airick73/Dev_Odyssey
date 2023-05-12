import 'package:dev_odyssey/login/login.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'package:dev_odyssey/shared/shared.dart';
import 'package:dev_odyssey/services/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("My my an error on the home screen"),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Dev Odyssey',
              ),
              backgroundColor: Colors.greenAccent,
            ),
            body: const Center(
              child: Text("Home page"),
            ),
            bottomNavigationBar: const BottomNavBar(),
            drawer: Drawer(
              backgroundColor: Colors.redAccent,
              child: IconButton(
                icon: const Icon(FontAwesomeIcons.signOutAlt),
                onPressed: () => AuthService().signOut(),
              ),
            ),
          );
          ;
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
