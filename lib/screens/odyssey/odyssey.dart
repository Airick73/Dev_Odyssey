import 'package:dev_odyssey/models/entry_model.dart';
import 'package:dev_odyssey/models/odyssey_model.dart';
import 'package:dev_odyssey/widgets/entry_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dev_odyssey/services/firestore_database.dart';
import 'package:provider/provider.dart';

class OdysseyScreen extends StatelessWidget {
  // TO DO: add read/write and read-only ability based on if user is owner of odyssey
  final bool isOwner;
  const OdysseyScreen({super.key, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    final odyssey_provider = Provider.of<OdysseyModel>(context);
    final firestoreDatabase = Provider.of<FirestoreDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to your odyssey"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(odyssey_provider.name),
            Text(odyssey_provider.details),
            Expanded(
              child: StreamBuilder<OdysseyModel>(
                stream: firestoreDatabase.odysseyStream(
                    odysseyId: odyssey_provider.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final OdysseyModel? odyssey_stream = snapshot.data;
                    final List<EntryModel> entriesList =
                        odyssey_stream!.entries.values.toList();
                    entriesList.sort((a, b) => b.date.compareTo(a.date));
                    return ListView.builder(
                      itemCount: entriesList.length,
                      itemBuilder: (context, index) {
                        final EntryModel entry = entriesList[index];
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      entry.date,
                                      style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color:
                                            Color.fromARGB(255, 205, 163, 11),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: Colors.blue),
                                          onPressed: () {
                                            // Edit entry functionality here
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () {
                                            firestoreDatabase.deleteEntry(
                                                odyssey_stream.id, entry.id);
                                            odyssey_provider.entries
                                                .remove(entry.id);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  entry.text,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.cyan,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    print('Snapshot error: ${snapshot.error}');
                    return const Center(
                        child:
                            Text('Snapshot has error. Cannot display Entry'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Provider<OdysseyModel>(
        create: (context) => odyssey_provider,
        child: const EntryNavBar(
          left: "people",
          middle: "Entry",
          right: "resources",
          leftIcon: FontAwesomeIcons.portrait,
          middleIcon: FontAwesomeIcons.plus,
          rightIcon: FontAwesomeIcons.book,
        ),
      ),
    );
  }
}
