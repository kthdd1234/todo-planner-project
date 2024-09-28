import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/main.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';

class MemoMethod {
  String uid = auth.currentUser!.uid;

  Stream<QuerySnapshot> get memoSnapshots {
    return firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(memosCollection)
        .snapshots();
  }

  Future<bool> addMemo({
    required String mid,
    required MemoInfoClass memoInfo,
  }) async {
    await firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(memosCollection)
        .doc(mid)
        .set(memoInfo.toJson());

    return true;
  }

  Future<bool> updateMemo({
    required String mid,
    required MemoInfoClass memoInfo,
  }) async {
    await firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(memosCollection)
        .doc(mid)
        .set(memoInfo.toJson());

    return true;
  }

  Future<bool> removeMemo({required String mid}) async {
    await firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(memosCollection)
        .doc(mid)
        .delete();

    return true;
  }
}
