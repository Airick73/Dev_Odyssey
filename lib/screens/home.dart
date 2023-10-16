import 'package:dev_odyssey/models/user_model.dart';
import 'package:dev_odyssey/providers/auth_provider.dart';
import 'package:dev_odyssey/routes.dart';
import 'package:dev_odyssey/widgets/bottom_nav_bar.dart';
import 'package:dev_odyssey/widgets/restart.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<UserModel>(
              stream: authProvider.user,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Text(snapshot.data?.uid ?? 'Loading...'),
                    Text(snapshot.data?.email ?? 'Loading...'),
                    Text(snapshot.data?.displayName ?? 'Loading...'),
                    Text(snapshot.data?.phoneNumber ?? 'Loading...'),
                    Text(snapshot.data?.photoUrl ?? 'Loading...'),
                  ],
                );
              },
            ),
            ElevatedButton(
                onPressed: () {
                  print("${authProvider.status}");
                },
                child: const Text("status")),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(
          left: "friends",
          middle: "odysseys",
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
            Restart.restartApp(context);
          },
        ),
      ),
    );
  }
}
