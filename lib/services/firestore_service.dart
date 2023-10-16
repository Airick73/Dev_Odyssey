import 'package:cloud_firestore/cloud_firestore.dart';

/*
This class represents all possible CRUD (Create, Read, Update, Delete) operations for FirebaseFirestore.
It contains generic implementations based on the provided document path and document ID, as most of the time
in FirebaseFirestore design, we will have a document ID and path for any document and collection.
*/
class FirestoreService {
  FirestoreService._(); //declaring class constructor as private
  static final instance = FirestoreService._(); //singleton paradigm

  // Sets data in the specified document path
  Future<void> set({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }

  // Deletes data from the specified document path
  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
  }

  Future<void> deleteKeyValuePair(
      {required String path,
      required String field,
      required String key}) async {
    final odysseyRef = FirebaseFirestore.instance.doc(path);

    final DocumentSnapshot docSnapshot = await odysseyRef.get();

    if (docSnapshot.exists) {
      final Map<String, dynamic> data =
          docSnapshot.data() as Map<String, dynamic>;
      final Map<String, dynamic>? targetMap =
          data[field] as Map<String, dynamic>?;

      if (targetMap != null && targetMap.containsKey(key)) {
        // Remove the key-value pair from the map
        targetMap.remove(key);
        // Update the document with the modified map
        await odysseyRef.update({field: targetMap});
      }
    }
  }

  // Returns a stream of a collection as a list of items
  Stream<List<T>> collectionStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String documentID),
    Query queryBuilder(Query query)?,
    int sort(T lhs, T rhs)?,
  }) {
    // Create a query for the specified collection path
    Query query = FirebaseFirestore.instance.collection(path);

    // If a query builder function is provided, modify the query using the builder
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    // Retrieve a stream of query snapshots
    final Stream<QuerySnapshot> snapshots = query.snapshots();

    // Map the query snapshots to a list of items
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();

      // If a sort function is provided, sort the list
      if (sort != null) {
        result.sort(sort);
      }

      return result;
    });
  }

  // Returns a stream of a single document
  Stream<T> documentStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String documentID),
  }) {
    // Create a reference to the specified document path
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);

    // Retrieve a stream of document snapshots
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();

    // Map the document snapshots to an instance of T
    return snapshots.map((snapshot) =>
        builder(snapshot.data() as Map<String, dynamic>, snapshot.id));
  }

  // // Sets multiple data in bulk for the specified document path
  // Future<void> bulkSet({
  //   required String path,
  //   required List<Map<String, dynamic>> datas,
  //   bool merge = false,
  // }) async {
  //   final reference = FirebaseFirestore.instance.doc(path);
  //   final batchSet = FirebaseFirestore.instance.batch();

  //   // TODO: Implement logic for batch set

  //   print('$path: $datas');
  // }
}
