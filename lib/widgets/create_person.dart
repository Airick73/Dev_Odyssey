import 'package:dev_odyssey/models/odyssey_model.dart';
import 'package:dev_odyssey/models/person_model.dart';
import 'package:dev_odyssey/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePerson extends StatelessWidget {
  const CreatePerson({
    super.key,
    required this.personNameController,
    required this.personPictureController,
    required this.personDetailsController,
  });
  final TextEditingController personNameController,
      personPictureController,
      personDetailsController;

  @override
  Widget build(BuildContext context) => Column(children: [
        TextField(
            controller: personNameController,
            decoration: const InputDecoration(labelText: 'Person Name')),
        TextField(
            controller: personPictureController,
            decoration: const InputDecoration(labelText: 'Person Picture')),
        TextField(
            controller: personDetailsController,
            decoration: const InputDecoration(labelText: 'Person Details')),
        ElevatedButton(
          onPressed: () {
            final odyssey = Provider.of<OdysseyModel>(context, listen: false);
            final newPerson = PersonModel(
              id: documentIdFromCurrentDate(),
              name: personNameController.text,
              picture: personPictureController.text,
              details: personDetailsController.text,
            );
            odyssey.people[newPerson.id] = newPerson;
          },
          child: const Text('Add Person'),
        ),
      ]);
}
