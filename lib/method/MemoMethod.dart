import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/main.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/func.dart';

class MemoMethod {
  String get uid => auth.currentUser!.uid;

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
    try {
      await firestore
          .collection(usersCollection)
          .doc(uid)
          .collection(memosCollection)
          .doc(mid)
          .set(memoInfo.toJson());

      return true;
    } catch (e) {
      errorMessage(msg: '알 수 없는 에러가 발생했어요');
      return false;
    }
  }

  Future<bool> updateMemo({
    required String mid,
    required MemoInfoClass memoInfo,
  }) async {
    try {
      await firestore
          .collection(usersCollection)
          .doc(uid)
          .collection(memosCollection)
          .doc(mid)
          .set(memoInfo.toJson());

      return true;
    } catch (e) {
      errorMessage(msg: '알 수 없는 에러가 발생했어요');
      return false;
    }
  }

  Future<bool> removeMemo({required String mid}) async {
    try {
      await firestore
          .collection(usersCollection)
          .doc(uid)
          .collection(memosCollection)
          .doc(mid)
          .delete();

      return true;
    } catch (e) {
      errorMessage(msg: '알 수 없는 에러가 발생했어요');
      return false;
    }
  }

  Future<bool> removeAllMemo({required List<String> memoIdList}) async {
    try {
      for (final memoId in memoIdList) {
        await removeMemo(mid: memoId);
      }

      return true;
    } catch (e) {
      errorMessage(msg: '알 수 없는 에러가 발생했어요');
      return false;
    }
  }
}
