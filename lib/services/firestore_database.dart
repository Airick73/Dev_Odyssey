import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_odyssey/models/odyssey.dart';
import 'package:dev_odyssey/services/firestore_service.dart';
import 'package:dev_odyssey/services/firestore_path.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

/*
This is the main class access/call for any UI widgets that require to perform
any CRUD activities operation in FirebaseFirestore database.
This class work hand-in-hand with FirestoreService and FirestorePath.

Notes:
For cases where you need to have a special method such as bulk update specifically
on a field, then is ok to use custom code and write it here. For example,
setAllodysseyComplete is require to change all odysseys item to have the complete status
changed to true.

 */
class FirestoreDatabase {
  FirestoreDatabase({required this.uid}) {
    print('FirestoreDatabase uid: $uid'); // Add this line
  }
  final String uid;

  final _firestoreService = FirestoreService.instance;

  //Method to create/update OdysseyModel
  Future<void> setOdyssey(OdysseyModel odyssey) async {
    print('setOdyssey uid: $uid'); // Add this line
    await _firestoreService.set(
      path: FirestorePath.odyssey(uid, odyssey.id),
      data: odyssey.toMap(),
    );
  }

  //Method to retrieve OdysseyModel object based on the given odysseyId
  Stream<OdysseyModel> odysseyStream({required String odysseyId}) {
    print('odysseyStream uid: $uid'); // Add this line
    return _firestoreService.documentStream(
      path: FirestorePath.odyssey(uid, odysseyId),
      builder: (data, documentId) => OdysseyModel.fromMap(data, documentId),
    );
  }

  //Method to retrieve all odysseys item from the same user based on uid
  Stream<List<OdysseyModel>> odysseysStream() {
    print('odysseysStream uid: $uid'); // Add this line
    return _firestoreService.collectionStream(
      path: FirestorePath.odysseys(uid),
      builder: (data, documentId) => OdysseyModel.fromMap(data, documentId),
    );
  }

  //Method to mark all OdysseyModel to be complete
  Future<void> setAllodysseyComplete() async {
    print('setAllodysseyComplete uid: $uid'); // Add this line
    final batchUpdate = FirebaseFirestore.instance.batch();

    final querySnapshot = await FirebaseFirestore.instance
        .collection(FirestorePath.odysseys(uid))
        .get();

    for (DocumentSnapshot ds in querySnapshot.docs) {
      batchUpdate.update(ds.reference, {'complete': true});
    }
    await batchUpdate.commit();
  }

  Future<void> deleteAllOdysseyWithComplete() async {
    print('deleteAllOdysseyWithComplete uid: $uid'); // Add this line
    final batchDelete = FirebaseFirestore.instance.batch();

    final querySnapshot = await FirebaseFirestore.instance
        .collection(FirestorePath.odysseys(uid))
        .where('complete', isEqualTo: true)
        .get();

    for (DocumentSnapshot ds in querySnapshot.docs) {
      batchDelete.delete(ds.reference);
    }
    await batchDelete.commit();
  }
}
