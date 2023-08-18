import 'package:dev_odyssey/models/odyssey_model.dart';
import 'package:dev_odyssey/models/person_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final odyssey = Provider.of<OdysseyModel>(context);
    final people = odyssey.people.values.toList();

    // Determine the number of columns based on screen width
    final width = MediaQuery.of(context).size.width;
    final columns = width ~/ 150; // 150 is the approximate width of each item

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to the people screen"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          childAspectRatio: 0.8,
        ),
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return _buildPersonCard(person);
        },
      ),
    );
  }

  Widget _buildPersonCard(PersonModel person) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: person.picture.isNotEmpty
                  ? NetworkImage(person.picture)
                  : null, //const AssetImage('assets/default_image.png'), // Default image
              radius: 40,
            ),
            const SizedBox(height: 8),
            Text(
              person.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
