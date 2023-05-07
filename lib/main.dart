import 'package:dev_odyssey/routes.dart';
import 'package:dev_odyssey/shared/shared.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import "package:flutter/material.dart";

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Good heavens an error occured!"));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              routes: appRoutes,
            );
          } else {
            return const LoadingScreen();
          }
        },
      ),
    );
  }
}
