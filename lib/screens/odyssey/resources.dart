import 'package:dev_odyssey/models/odyssey_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the number of columns based on screen width
    final width = MediaQuery.of(context).size.width;
    final columns = width > 600
        ? 3
        : 2; // Example: 3 columns for wide screens, 2 for narrow
    final odyssey = Provider.of<OdysseyModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to the resources screen"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          childAspectRatio: 3 / 2, // Adjust as needed
        ),
        itemCount: odyssey.resources.length,
        itemBuilder: (context, index) {
          final resource = odyssey.resources.values.elementAt(index);
          return Card(
            child: Column(
              children: [
                if (resource.picture != null)
                  Image.network(
                      resource.picture!), // Display picture if available
                Text(resource.note ?? 'No note available'),
                Text(resource.link ?? 'No link available'),
              ],
            ),
          );
        },
      ),
    );
  }
}
