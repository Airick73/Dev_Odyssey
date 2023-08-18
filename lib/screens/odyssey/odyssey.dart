import 'package:dev_odyssey/models/entry_model.dart';
import 'package:dev_odyssey/models/odyssey_model.dart';
import 'package:dev_odyssey/widgets/entry_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dev_odyssey/services/firestore_database.dart';
import 'package:provider/provider.dart';

class OdysseyScreen extends StatelessWidget {
  const OdysseyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final odyssey = Provider.of<OdysseyModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to your odyssey"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(odyssey.name),
            Text(odyssey.details),
            const Expanded(
              child: EntryList(),
            )
          ],
        ),
      ),
      bottomNavigationBar: Provider<OdysseyModel>(
        create: (context) => odyssey,
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

class EntryList extends StatelessWidget {
  const EntryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final firestoreDatabase = Provider.of<FirestoreDatabase>(context);
    final odyssey = Provider.of<OdysseyModel>(context);
    return StreamBuilder<OdysseyModel>(
      stream: firestoreDatabase.odysseyStream(odysseyId: odyssey.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final OdysseyModel? odyssey = snapshot.data;
          final List<EntryModel> entriesList = odyssey!.entries.values.toList();
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
                      Text(
                        entry.date,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 205, 163, 11),
                        ),
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
              child: Text('Snapshot has error. Cannot display Entry'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
