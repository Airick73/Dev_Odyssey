import 'package:flutter/material.dart';

// Define a StatefulWidget. This allows you to create a widget that can change over time.
class Restart extends StatefulWidget {
  // The constructor takes a child widget that this widget will render as part of its widget tree.
  const Restart({super.key, required this.child});

  final Widget child; // The child widget that this widget will render.

  // A static method that can be used to restart the app.
  // It finds the nearest _RestartState ancestor from the given BuildContext and calls its restartApp() method.
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartState>()!.restartApp();
  }

  // Create the mutable state for this widget.
  @override
  _RestartState createState() => _RestartState();
}

// Define the state object for the Restart. This object is created by the createState() method.
class _RestartState extends State<Restart> {
  // A unique key that can be used to force the widget tree to rebuild.
  Key key = UniqueKey();

  // A method that changes the key to a new unique key, which forces Flutter to rebuild the widget tree.
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  // Define the build method for this widget. This returns a KeyedSubtree widget that uses the unique key and the child widget.
  // The KeyedSubtree is a utility widget that ensures that the subtree can be uniquely identified even across widget rebuilds.
  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
