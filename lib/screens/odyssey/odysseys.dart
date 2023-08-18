import 'package:dev_odyssey/models/odyssey_model.dart';
import 'package:dev_odyssey/screens/odyssey/odyssey.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dev_odyssey/services/firestore_database.dart';
import 'package:dev_odyssey/widgets/create_odyssey.dart';

class OdysseysScreen extends StatelessWidget {
  const OdysseysScreen({super.key});

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
                    content: CreateOdyssey(),
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
                      final OdysseyModel odyssey = odysseys[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Provider<OdysseyModel>(
                                create: (context) => odyssey,
                                child: const OdysseyScreen(),
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(odyssey.name),
                          subtitle: Text(odyssey.details),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  print('Snapshot error: ${snapshot.error}');
                  return const Center(
                      child:
                          Text('Snapshot has error. Cannot display Odysseys'));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }
}
