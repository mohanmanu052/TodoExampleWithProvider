import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eired_sample/constants/error_message_constants.dart';
import 'package:eired_sample/constants/utils.dart';

abstract class IAddTodoService {
  Future<int> addTodoData(String userId, Map<String, dynamic> todaData);
  Future<int> updateTodo(
      String userId, String documentId, Map<String, dynamic> data);
}

class AddTodoService implements IAddTodoService {
  @override
  Future<int> addTodoData(String userId, Map<String, dynamic> todaData) async {
    int? resCode;

    DocumentReference key =
        collectionReference.doc(userId).collection('Todo').doc();

    String documentId = key.id;
    todaData['documentId'] = documentId;

    var res = await key.set(todaData).then((value) {
      print('data uploaded');
      return resCode = ErrorMessageConstants.addTodoDataAdded;
    });
    return resCode ?? 0;

    // TODO: implement addTodoData
  }

  @override
  Future<int> updateTodo(
      String userId, String documentId, Map<String, dynamic> data) async {
    // TODO: implement updateTodo
    int? rescode;
    try {
      var res = await collectionReference
          .doc(userId)
          .collection('Todo')
          .doc(documentId)
          .set(
            data,
            SetOptions(
              merge: true,
            ),
          );
      return rescode = ErrorMessageConstants.addTodoDataAdded;
    } catch (err) {
      return rescode = ErrorMessageConstants.addTodoErrorOccured;
    }
  }
}
