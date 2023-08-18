import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final String left;
  final String middle;
  final String right;
  final IconData leftIcon;
  final IconData middleIcon;
  final IconData rightIcon;

  const BottomNavBar(
      {super.key,
      required this.left,
      required this.middle,
      required this.right,
      required this.leftIcon,
      required this.middleIcon,
      required this.rightIcon});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: [
      BottomNavigationBarItem(
        icon: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/$left');
          },
          icon: Icon(leftIcon),
        ),
        label: left,
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/$middle');
          },
          icon: Icon(middleIcon),
        ),
        label: middle,
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/$right');
          },
          icon: Icon(rightIcon),
        ),
        label: right,
      )
    ]);
  }
}
