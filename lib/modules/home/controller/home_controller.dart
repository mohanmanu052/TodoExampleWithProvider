import 'package:eired_sample/constants/error_message_constants.dart';
import 'package:eired_sample/constants/shareprefrence_constants.dart';
import 'package:eired_sample/modules/home/homescreen.dart';
import 'package:eired_sample/modules/home/provider/homescreen_provider.dart';
import 'package:eired_sample/modules/home/provider/homescreen_service.dart';
import 'package:eired_sample/modules/todo/model/todo_model.dart';
import 'package:eired_sample/reusable/custom_snackbar.dart';
import 'package:flutter/material.dart';

enum DataState { LOADING, EMPTY, ERROR, SUCCESS, UNKNOWN }

class HomeController with ChangeNotifier {
  IHomeScreenService? provider;
  List<TodoModel> todoData = [];
  HomeController(IHomeScreenService apiService) {
    provider = apiService;
  }
  DataState loadingState = DataState.UNKNOWN;
  String userEmailorNumber = '';
  String userId = '';

  Future<dynamic> getTodoList() async {
    print('the user is in home screen was----' + userId.toString());
    loadingState = DataState.LOADING;
    notifyListeners();
    var data = await provider?.getTodoListData(userId);

    if (data!.docs.isEmpty) {
      loadingState = DataState.EMPTY;
      notifyListeners();
    } else {
      todoData = data.docs
          .map((docSnapshot) => TodoModel.fromJson(docSnapshot))
          .toList();
      loadingState = DataState.SUCCESS;
      notifyListeners();
    }
  }

  Future<void> getUserMobilenumbername() async {
    List<String> data = await SharedPrefrenceLocal.getuserEmailorNumber();
    userEmailorNumber = data[0];
    userId = data[1];
    print('the user id in shared prefrence was-------' + userId.toString());
    notifyListeners();
    getTodoList();
  }

  Future<void> deleteDocument(TodoModel model, BuildContext ctx) async {
    todoData.remove(model);
    notifyListeners();
    String userId = await SharedPrefrenceLocal.getUserId();

    var res = await provider?.deleteDocument(userId, model.documentId ?? '');

    print('the response code wass-----' + res.toString());
    if (res == ErrorMessageConstants.documentDeletedSucess) {
      CustomSnackBar.showSnackBar('Documnet Deleted Sucessfully', ctx);
      Navigator.push(
          ctx, MaterialPageRoute(builder: ((context) => HomeScreen())));
    } else {
      CustomSnackBar.showSnackBar(
          ErrorMessageConstants.someErrorOcurredMessage, ctx);
    }
  }
}
