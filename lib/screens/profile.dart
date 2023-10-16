import 'package:flutter/material.dart';
import 'package:dev_odyssey/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  final String userId; // User ID to query the profile

  const ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.greenAccent,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final UserModel user = UserModel(
              uid: snapshot.data!.id,
              email: snapshot.data!['email'],
              displayName: snapshot.data!['displayName'],
              phoneNumber: snapshot.data!['phoneNumber'],
              photoUrl: snapshot.data!['photoUrl'],
            );
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: user.photoUrl != null
                          ? NetworkImage(user.photoUrl!)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.displayName ?? 'No Name',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email ?? 'No Email',
                    style: const TextStyle(
                        fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                  // Add other widgets like phone number, friend button, etc. here
                ],
              ),
            );
          } else if (snapshot.hasError) {
            print('Snapshot error: ${snapshot.error}');
            return const Center(
                child: Text('An error occurred. Cannot display profile.'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
