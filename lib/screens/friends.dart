import 'package:dev_odyssey/routes.dart';
import 'package:dev_odyssey/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:dev_odyssey/models/user_model.dart';
import 'package:provider/provider.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firestoreDatabase = Provider.of<FirestoreDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add friend functionality here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search friends...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                // Search functionality here
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<UserModel>(
              stream: firestoreDatabase.userStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final UserModel? user = snapshot.data;
                  final friendsUids = user?.friends ?? ['No Friends'];

                  return ListView.builder(
                    itemCount: friendsUids.length,
                    itemBuilder: (context, index) {
                      final friendUid = friendsUids[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.profile,
                            arguments: friendUid,
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading:
                                const Icon(Icons.person, color: Colors.blue),
                            title: Text('Friend UID: $friendUid',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    // Edit friend functionality here
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    // Delete friend functionality here
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('An error occurred.'));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
