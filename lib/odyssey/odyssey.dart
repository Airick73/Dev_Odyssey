import 'package:dev_odyssey/services/auth.dart';
import 'package:dev_odyssey/services/firestore.dart';
import 'package:dev_odyssey/services/models.dart';
import 'package:flutter/material.dart';
import 'package:dev_odyssey/shared/shared.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../services/doUserProvider.dart';

class OdysseyScreen extends StatelessWidget {
  const OdysseyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doUserProvider = Provider.of<DevOdysseyUserProvider>(context);
    final doUser = doUserProvider.doUser;
    final odysseys = doUser!.odysseys;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to your odysseys"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text('Create Odyssey'),
                    content: CreateOdysseyWidget(),
                  ),
                );
              },
              child: const Text('Start a new Odyssey'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: odysseys.length,
              itemBuilder: (context, index) {
                final odyssey = odysseys[index];
                return ListTile(
                  title: Text(odyssey.odysseyName),
                  subtitle: Text(odyssey.odysseyDetails),
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomNavBar(
        left: "people",
        middle: "odyssey",
        right: "resources",
        leftIcon: FontAwesomeIcons.portrait,
        middleIcon: FontAwesomeIcons.mountain,
        rightIcon: FontAwesomeIcons.book,
      ),
    );
  }
}

class CreateOdysseyWidget extends StatefulWidget {
  const CreateOdysseyWidget({super.key});

  @override
  _CreateOdysseyWidgetState createState() => _CreateOdysseyWidgetState();
}

class _CreateOdysseyWidgetState extends State<CreateOdysseyWidget> {
  final TextEditingController _odysseyNameController = TextEditingController();
  final TextEditingController _odysseyDetailsController =
      TextEditingController();

  @override
  void dispose() {
    _odysseyNameController.dispose();
    _odysseyDetailsController.dispose();
    super.dispose();
  }

  void _createOdyssey() {
    final String odysseyName = _odysseyNameController.text;
    final String odysseyDetails = _odysseyDetailsController.text;

    // Create an instance of the Odyssey model
    final Odyssey newOdyssey = Odyssey(
      odysseyName: odysseyName,
      odysseyDetails: odysseyDetails,
      // Add any other desired properties
    );

    // Call the Firestore service to add the new odyssey
    OdysseyService().addOdyssey(newOdyssey);

    // Clear the text fields after creating the odyssey
    _odysseyNameController.clear();
    _odysseyDetailsController.clear();

    // Show a success message or navigate to a different screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Odyssey created successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _odysseyNameController,
          decoration: const InputDecoration(labelText: 'Odyssey Name'),
        ),
        TextField(
          controller: _odysseyDetailsController,
          decoration: const InputDecoration(labelText: 'Odyssey Details'),
        ),
        ElevatedButton(
          onPressed: _createOdyssey,
          child: const Text('Create Odyssey'),
        ),
      ],
    );
  }
}
