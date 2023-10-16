import 'dart:math';

import 'package:dev_odyssey/models/odyssey_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dev_odyssey/models/entry_model.dart';
import 'package:dev_odyssey/services/firestore_database.dart';
import 'package:dev_odyssey/widgets/create_person.dart';
import 'package:dev_odyssey/widgets/create_resource.dart';

class CreateEntry extends StatefulWidget {
  const CreateEntry({Key? key}) : super(key: key);

  @override
  _CreateEntryState createState() => _CreateEntryState();
}

class _CreateEntryState extends State<CreateEntry> {
  final _textController = TextEditingController(),
      _dateController = TextEditingController(),
      _personNameController = TextEditingController(),
      _personPictureController = TextEditingController(),
      _personDetailsController = TextEditingController(),
      _resourcePictureController = TextEditingController(),
      _resourceNoteController = TextEditingController(),
      _resourceLinkController = TextEditingController();
  String? _selectedContentType;
  bool _isPersonExpanded = false, _isResourceExpanded = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final odyssey = Provider.of<OdysseyModel>(context, listen: true);
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: const Text('Add Entry'),
      content: SizedBox(
        width: width * 0.75,
        height: height * 0.75,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now().add(const Duration(days: 3650)),
                    );
                    if (pickedDate != null) {
                      _dateController.text =
                          "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
                    }
                  },
                ),
                TextFormField(
                  controller: _textController,
                  decoration: const InputDecoration(labelText: 'Text'),
                ),
                ExpansionPanelList(
                  expansionCallback: (index, isExpanded) => setState(() {
                    index == 0
                        ? _isPersonExpanded = !isExpanded
                        : _isResourceExpanded = !isExpanded;
                  }),
                  children: [
                    ExpansionPanel(
                      headerBuilder: (context, isExpanded) =>
                          const ListTile(title: Text('Persons')),
                      body: CreatePerson(
                        personNameController: _personNameController,
                        personPictureController: _personPictureController,
                        personDetailsController: _personDetailsController,
                      ),
                      isExpanded: _isPersonExpanded,
                    ),
                    ExpansionPanel(
                      headerBuilder: (context, isExpanded) =>
                          const ListTile(title: Text('Resources')),
                      body: CreateResource(
                        resourcePictureController: _resourcePictureController,
                        resourceNoteController: _resourceNoteController,
                        resourceLinkController: _resourceLinkController,
                        selectedContentType: _selectedContentType,
                        onContentTypeChanged: (newValue) => setState(() {
                          _selectedContentType = newValue;
                        }),
                      ),
                      isExpanded: _isResourceExpanded,
                    ),
                  ],
                ),
                if (odyssey.people.isNotEmpty)
                  _buildAddedItemsList(odyssey.people, 'Persons'),
                if (odyssey.resources.isNotEmpty)
                  _buildAddedItemsList(odyssey.resources, 'Resources'),
              ],
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => _saveEntry(context),
          child: const Text('Save'),
        ),
        ElevatedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Widget _buildAddedItemsList(Map<String, dynamic> items, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Text(
            'Added $title:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items.values.elementAt(index);
            String displayValue =
                item.picture ?? item.note ?? item.link ?? 'Unknown';
            return ListTile(
              title: Text(displayValue),
            );
          },
        ),
      ],
    );
  }

  void _saveEntry(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Validate the form
      _formKey.currentState!.save(); // Save the form
      FocusScope.of(context).unfocus();
      final firestoreDatabase =
          Provider.of<FirestoreDatabase>(context, listen: false);
      final odyssey = Provider.of<OdysseyModel>(context, listen: false);
      var entry = EntryModel(
        id: documentIdFromCurrentDate(),
        text: _textController.text,
        date: _dateController.text,
      );
      odyssey.entries[entry.id] = entry;
      firestoreDatabase.setOdyssey(odyssey);

      _textController.clear();
      _dateController.clear();
      _personNameController.clear();
      _personPictureController.clear();
      _personDetailsController.clear();
      _resourcePictureController.clear();
      _resourceNoteController.clear();
      _resourceLinkController.clear();

      Navigator.of(context).pop();
    }
  }
}
