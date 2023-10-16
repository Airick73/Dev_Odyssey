import 'package:flutter/material.dart';
import 'package:dev_odyssey/models/odyssey_model.dart';
import 'package:dev_odyssey/services/firestore_database.dart';
import 'package:provider/provider.dart';
import 'package:dev_odyssey/screens/odyssey/odyssey.dart'; // Import the Odyssey screen

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore"),
      ),
      body: StreamBuilder<List<OdysseyModel>>(
        stream: firestoreDatabase.allOdysseysStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final odysseys = snapshot.data;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
              ),
              itemCount: odysseys!.length,
              itemBuilder: (context, index) {
                final OdysseyModel odyssey = odysseys[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Provider<OdysseyModel>(
                          create: (context) => odyssey,
                          child: const OdysseyScreen(
                            isOwner: true, // FIX ME
                          ),
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Center(
                      child: Text(odyssey.name),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            print('Snapshot error: ${snapshot.error}');
            return const Center(
                child: Text('Snapshot has error. Cannot display Odysseys'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
