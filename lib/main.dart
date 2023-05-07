import 'package:dev_odyssey/shared/loading.dart';
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
      home: Scaffold(
        body: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error'));
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Center(child: Text('App'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
