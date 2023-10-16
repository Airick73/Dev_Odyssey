import 'package:dev_odyssey/models/odyssey_model.dart';
import 'package:dev_odyssey/models/resource_model.dart';
import 'package:dev_odyssey/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateResource extends StatelessWidget {
  const CreateResource({
    super.key,
    required this.resourcePictureController,
    required this.resourceNoteController,
    required this.resourceLinkController,
    required this.selectedContentType,
    required this.onContentTypeChanged,
  });
  final TextEditingController resourcePictureController,
      resourceNoteController,
      resourceLinkController;
  final String? selectedContentType;
  final ValueChanged<String?> onContentTypeChanged;
  @override
  Widget build(BuildContext context) => Column(children: [
        DropdownButton<String>(
            value: selectedContentType,
            hint: const Text('Select content type'),
            onChanged: onContentTypeChanged,
            items: <String>['Picture', 'Note', 'Link']
                .map((value) =>
                    DropdownMenuItem<String>(value: value, child: Text(value)))
                .toList()),
        if (selectedContentType == 'Picture')
          TextField(
              controller: resourcePictureController,
              decoration:
                  const InputDecoration(labelText: 'Enter picture URL')),
        if (selectedContentType == 'Note')
          TextField(
              controller: resourceNoteController,
              decoration: const InputDecoration(labelText: 'Enter note')),
        if (selectedContentType == 'Link')
          TextField(
              controller: resourceLinkController,
              decoration: const InputDecoration(labelText: 'Enter link URL')),
        ElevatedButton(
          onPressed: () {
            final odyssey = Provider.of<OdysseyModel>(context, listen: false);
            final newResource = ResourceModel(
              id: documentIdFromCurrentDate(),
              picture: selectedContentType == 'Picture'
                  ? resourcePictureController.text
                  : null,
              note: selectedContentType == 'Note'
                  ? resourceNoteController.text
                  : null,
              link: selectedContentType == 'Link'
                  ? resourceLinkController.text
                  : null,
            );
            odyssey.resources[newResource.id] = newResource;
          },
          child: const Text('Add Resource'),
        ),
      ]);
}
