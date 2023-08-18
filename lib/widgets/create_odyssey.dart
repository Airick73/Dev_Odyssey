import 'package:dev_odyssey/models/odyssey_model.dart';
import 'package:flutter/material.dart';
import 'package:dev_odyssey/services/firestore_database.dart';
import 'package:provider/provider.dart';

class CreateOdyssey extends StatefulWidget {
  const CreateOdyssey({super.key});

  @override
  _CreateOdysseyState createState() => _CreateOdysseyState();
}

class _CreateOdysseyState extends State<CreateOdyssey> {
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

    Navigator.of(context).pop();
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
