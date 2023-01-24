import 'package:eired_sample/modules/todo/provider/add_todo_service.dart';

class AddTodoServiceProvider {
  static IAddTodoService getService() {
    return AddTodoService();
  }
}
