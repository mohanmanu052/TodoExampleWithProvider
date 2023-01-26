import 'dart:ffi';

import 'package:eired_sample/constants/error_message_constants.dart';
import 'package:eired_sample/constants/shareprefrence_constants.dart';
import 'package:eired_sample/modules/home/provider/homescreen_service.dart';
import 'package:eired_sample/modules/todo/model/todo_model.dart';
import 'package:eired_sample/reusable/custom_snackbar.dart';
import 'package:flutter/material.dart';

enum ViewTodoLoadingState { LOADING, SUCCESS, ERROR, UNKNOWN, EMPTY }

class TodoViewController with ChangeNotifier {
  ViewTodoLoadingState loadingState = ViewTodoLoadingState.UNKNOWN;

  IHomeScreenService? apiService;
  TodoViewController(IHomeScreenService service) {
    apiService = service;
  }
  List<TodoModel> todoData = [];

  String userId = '';

  Future<dynamic> getTodoList() async {
    String userId = await SharedPrefrenceLocal.getUserId();

    print('the user id was----' + userId.toString());
    loadingState = ViewTodoLoadingState.LOADING;
    notifyListeners();

    var data = await apiService?.getTodoListData(userId);

    if (data!.docs.isEmpty) {
      loadingState = ViewTodoLoadingState.EMPTY;
      notifyListeners();
    } else {
      print('docs is not empty----');
      todoData = data.docs
          .map((docSnapshot) => TodoModel.fromJson(docSnapshot))
          .toList();
      loadingState = ViewTodoLoadingState.SUCCESS;
      notifyListeners();
    }
  }

  Future<void> deleteDocument(TodoModel model, BuildContext ctx) async {
    todoData.remove(model);
    notifyListeners();
    String userId = await SharedPrefrenceLocal.getUserId();

    var res = await apiService?.deleteDocument(userId, model.documentId ?? '');

    print('the response code wass-----' + res.toString());
    if (res == ErrorMessageConstants.documentDeletedSucess) {
      CustomSnackBar.showSnackBar('Documnet Deleted Sucessfully', ctx);
    } else {
      CustomSnackBar.showSnackBar(
          ErrorMessageConstants.someErrorOcurredMessage, ctx);
    }
  }
}
