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
        backgroundColor: const Color.fromARGB(221, 205, 19, 19),
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
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(221, 213, 12, 12)),
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
                                child: const OdysseyScreen(
                                  isOwner: true, //FIX ME
                                ),
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  odyssey.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  odyssey.details,
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue),
                                      onPressed: () {
                                        // Edit odyssey functionality here
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        firestoreDatabase
                                            .deleteOdyssey(odyssey.id);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
