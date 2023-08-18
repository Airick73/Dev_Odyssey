import 'package:dev_odyssey/models/odyssey_model.dart';
import 'package:dev_odyssey/screens/odyssey/people.dart';
import 'package:dev_odyssey/screens/odyssey/resources.dart';
import 'package:dev_odyssey/widgets/create_entry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntryNavBar extends StatelessWidget {
  final String left;
  final String middle;
  final String right;
  final IconData leftIcon;
  final IconData middleIcon;
  final IconData rightIcon;

  const EntryNavBar({
    super.key,
    required this.left,
    required this.middle,
    required this.right,
    required this.leftIcon,
    required this.middleIcon,
    required this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    final odyssey = Provider.of<OdysseyModel>(context, listen: false);

    return BottomNavigationBar(items: [
      BottomNavigationBarItem(
        icon: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Provider<OdysseyModel>(
                  create: (context) => odyssey,
                  child: const PeopleScreen(),
                ),
              ),
            );
          },
          icon: Icon(leftIcon),
        ),
        label: left,
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Provider<OdysseyModel>(
                create: (context) => odyssey,
                child: const CreateEntry(),
              ),
            );
          },
          icon: Icon(middleIcon),
        ),
        label: middle,
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Provider<OdysseyModel>(
                  create: (context) => odyssey,
                  child: const ResourcesScreen(),
                ),
              ),
            );
          },
          icon: Icon(rightIcon),
        ),
        label: right,
      ),
    ]);
  }
}
