import 'package:dev_odyssey/models/odyssey.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:dev_odyssey/services/firestore_database.dart';
import 'package:dev_odyssey/widgets/BottomNavBar.dart';

class OdysseyScreen extends StatelessWidget {
  const OdysseyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

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
            child: StreamBuilder<List<OdysseyModel>>(
              stream: firestoreDatabase.odysseysStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final odysseys = snapshot.data;
                  return ListView.builder(
                    itemCount: odysseys!.length,
                    itemBuilder: (context, index) {
                      final odyssey = odysseys[index];
                      return ListTile(
                        title: Text(odyssey.name),
                        subtitle: Text(odyssey.details),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong!'));
                }
                // While data is loading
                return const Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomNavBar(
        left: "people",
        middle: "Fix me",
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
  late TextEditingController _nameTextController = TextEditingController();
  late TextEditingController _detailsTextController = TextEditingController();
  OdysseyModel? _odyssey;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _detailsTextController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final OdysseyModel? _OdysseyModel =
        ModalRoute.of(context)?.settings.arguments as OdysseyModel?;
    if (_OdysseyModel != null) {
      _odyssey = _OdysseyModel;
    }

    _nameTextController = TextEditingController(text: _odyssey?.name ?? "");
    _detailsTextController =
        TextEditingController(text: _odyssey?.details ?? "");
  }

  void _createOdyssey() {
    // Create an instance of the Odyssey model
    final OdysseyModel newOdyssey = OdysseyModel(
      id: _odyssey?.id ?? documentIdFromCurrentDate(),
      name: _nameTextController.text,
      details: _detailsTextController.text.isNotEmpty
          ? _detailsTextController.text
          : "",
    );

    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    // Call the Firestore service to add the new odyssey
    firestoreDatabase.setOdyssey(newOdyssey);

    // Clear the text fields after creating the odyssey
    _nameTextController.clear();
    _detailsTextController.clear();

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
          controller: _nameTextController,
          decoration: const InputDecoration(labelText: 'Odyssey Name'),
        ),
        TextField(
          controller: _detailsTextController,
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
