import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eired_sample/constants/error_message_constants.dart';
import 'package:eired_sample/constants/utils.dart';

abstract class IHomeScreenService {
  Future<QuerySnapshot> getTodoListData(String userId);
  Future<int> deleteDocument(String userId, String docId);
}

class HomeScreenService implements IHomeScreenService {
  @override
  Future<QuerySnapshot> getTodoListData(String userId) {
    var ref = collectionReference.doc(userId).collection('Todo').get();
    return ref;
  }

  @override
  Future<int> deleteDocument(String userId, String docId) async {
    int? rescode;
    try {
      await collectionReference
          .doc(userId)
          .collection('Todo')
          .doc(docId)
          .delete()
          .then((val) {
        return rescode = ErrorMessageConstants.documentDeletedSucess;
      });
    } catch (err) {
      return rescode = ErrorMessageConstants.documentDeletedErr;
      ;
    }
    return rescode ?? 0;
    // TODO: implement deleteDocument
  }
}
