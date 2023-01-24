import 'package:eired_sample/constants/error_message_constants.dart';
import 'package:eired_sample/constants/shareprefrence_constants.dart';
import 'package:eired_sample/modules/home/homescreen.dart';
import 'package:eired_sample/modules/todo/provider/add_todo_service.dart';
import 'package:eired_sample/reusable/custom_snackbar.dart';
import 'package:flutter/material.dart';

enum AddTodoUploadingState { UNKNOWN, SUCCESS, LOADING }

class AddTodoController with ChangeNotifier {
  AddTodoUploadingState loadingState = AddTodoUploadingState.UNKNOWN;
  IAddTodoService? apiService;
  AddTodoController(IAddTodoService service) {
    apiService = service;
  }

  Future<void> addTodoData(String title, String Description, String categeory,
      String time, BuildContext ctx,
      {bool isUpdate = false, String documentId = ''}) async {
    loadingState = AddTodoUploadingState.LOADING;
    notifyListeners();
    String userId = '';

    if (userId.isEmpty || userId == null) {
      userId = await SharedPrefrenceLocal.getUserId();
      notifyListeners();
    }
    Map<String, dynamic> tododata = {
      'title': title,
      'description': Description,
      'category': categeory,
      'time': time,
      'date': DateTime.now()
    };

    if (isUpdate) {
      editTodoData(tododata, documentId, ctx, userId);
    } else {
      var res = await apiService?.addTodoData(userId, tododata);
      if (res == ErrorMessageConstants.addTodoDataAdded) {
        loadingState = AddTodoUploadingState.SUCCESS;
        notifyListeners();
        Navigator.push(
            ctx, MaterialPageRoute(builder: ((context) => HomeScreen())));
      } else {
        loadingState = AddTodoUploadingState.UNKNOWN;
        notifyListeners();
        CustomSnackBar.showSnackBar(
            ErrorMessageConstants.someErrorOcurredMessage, ctx);
      }
    }
  }

  Future<void> editTodoData(
    Map<String, dynamic> todoData,
    String documentId,
    BuildContext ctx,
    String userId,
  ) async {
    var res = await apiService?.updateTodo(userId, documentId, todoData);
    if (res == ErrorMessageConstants.addTodoDataAdded) {
      loadingState = AddTodoUploadingState.SUCCESS;
      notifyListeners();
      Navigator.push(
          ctx, MaterialPageRoute(builder: ((context) => HomeScreen())));
    } else {
      loadingState = AddTodoUploadingState.UNKNOWN;
      notifyListeners();
      CustomSnackBar.showSnackBar(
          ErrorMessageConstants.someErrorOcurredMessage, ctx);
    }
  }
}
