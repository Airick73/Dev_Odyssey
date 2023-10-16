import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_odyssey/models/odyssey_model.dart';
import 'package:dev_odyssey/models/user_model.dart';
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
  FirestoreDatabase({required this.uid});
  final String uid;

  final _firestoreService = FirestoreService.instance;

  //Method to create/update OdysseyModel
  Future<void> setOdyssey(OdysseyModel odyssey) async {
    await _firestoreService.set(
      path: FirestorePath.odyssey(uid, odyssey.id),
      data: odyssey.toMap(),
    );
  }

  Future<void> deleteOdyssey(String odysseyId) async {
    await _firestoreService.deleteData(
      path: FirestorePath.odyssey(uid, odysseyId),
    );
  }

  Future<void> deleteEntry(String odysseyId, String entryId) async {
    await _firestoreService.deleteKeyValuePair(
        path: FirestorePath.odyssey(uid, odysseyId),
        field: 'entries',
        key: entryId);
  }

  //Method to create/update OdysseyModel
  Future<void> setUser(UserModel user) async {
    await _firestoreService.set(
      path: FirestorePath.user(uid),
      data: user.toMap(),
    );
  }

  //Method to retrieve OdysseyModel object based on the given odysseyId
  Stream<UserModel> userStream() {
    return _firestoreService.documentStream(
      path: FirestorePath.user(uid),
      builder: (data, documentId) => UserModel.fromMap(data, documentId),
    );
  }

  //Method to retrieve OdysseyModel object based on the given odysseyId
  Stream<OdysseyModel> odysseyStream({required String odysseyId}) {
    return _firestoreService.documentStream(
      path: FirestorePath.odyssey(uid, odysseyId),
      builder: (data, documentId) => OdysseyModel.fromMap(data, documentId),
    );
  }

  //Method to retrieve all odysseys item from the same user based on uid
  Stream<List<OdysseyModel>> odysseysStream() {
    return _firestoreService.collectionStream(
      path: FirestorePath.odysseys(uid),
      builder: (data, documentId) => OdysseyModel.fromMap(data, documentId),
    );
  }

  Stream<List<OdysseyModel>> allOdysseysStream() {
    return FirebaseFirestore.instance
        .collectionGroup('odysseys')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map(
            (doc) => OdysseyModel.fromMap(
                doc.data() as Map<String, dynamic>, doc.id),
          )
          .toList();
    });
  }

  // //Method to mark all OdysseyModel to be complete
  // Future<void> setAllodysseyComplete() async {
  //   final batchUpdate = FirebaseFirestore.instance.batch();

  //   final querySnapshot = await FirebaseFirestore.instance
  //       .collection(FirestorePath.odysseys(uid))
  //       .get();

  //   for (DocumentSnapshot ds in querySnapshot.docs) {
  //     batchUpdate.update(ds.reference, {'complete': true});
  //   }
  //   await batchUpdate.commit();
  // }

  // Future<void> deleteAllOdysseyWithComplete() async {
  //   final batchDelete = FirebaseFirestore.instance.batch();

  //   final querySnapshot = await FirebaseFirestore.instance
  //       .collection(FirestorePath.odysseys(uid))
  //       .where('complete', isEqualTo: true)
  //       .get();

  //   for (DocumentSnapshot ds in querySnapshot.docs) {
  //     batchDelete.delete(ds.reference);
  //   }
  //   await batchDelete.commit();
  // }
}
