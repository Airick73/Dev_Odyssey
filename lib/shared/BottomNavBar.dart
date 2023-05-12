import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: [
      BottomNavigationBarItem(
        icon: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/friends');
          },
          icon: const Icon(FontAwesomeIcons.userFriends),
        ),
        label: 'Friends',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/odyssey');
          },
          icon: const Icon(FontAwesomeIcons.ship),
        ),
        label: 'Odyssey',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/explore');
          },
          icon: const Icon(FontAwesomeIcons.map),
        ),
        label: 'Explore',
      )
    ]);
  }
}
