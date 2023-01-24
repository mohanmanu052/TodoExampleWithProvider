import 'package:eired_sample/modules/todo/model/todo_model.dart';
import 'package:eired_sample/modules/todo/widget/add_todo_deatils.dart';
import 'package:eired_sample/modules/viewtodo/controller/todo_view_controller.dart';
import 'package:eired_sample/modules/viewtodo/widget/detail_todo_view.dart';
import 'package:eired_sample/reusable/custom_alert.dart';
import 'package:eired_sample/reusable/custom_appbar.dart';
import 'package:eired_sample/reusable/nodata_found.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  State<TodoListView> createState() => _TodoListState();
}

class _TodoListState extends State<TodoListView> {
  TodoViewController? controller;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller = Provider.of<TodoViewController>(context, listen: false);
      controller?.getTodoList();
      // Add Your Code here.
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoViewController>(builder: (context, controller, _) {
      return Scaffold(
        appBar: customAppBar(context, inputTitle: 'Todo List'),
        body: SafeArea(
            child: controller.loadingState == ViewTodoLoadingState.LOADING
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.loadingState == ViewTodoLoadingState.SUCCESS
                    ? ListView.builder(
                        itemCount: controller.todoData.length,
                        itemBuilder: ((context, index) =>
                            _listItem(controller.todoData[index], context)))
                    : NoDataFound(
                        onTrygainTap: (() => controller.getTodoList()),
                      )),
      );
    });
  }

  Widget _listItem(TodoModel data, BuildContext ctx) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => DetailTodoView(
                    data: data,
                  )))),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 1,
                      //  fit: FlexFit.tight,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                            foregroundImage: AssetImage(data.imageAsset ?? '')),
                        // height: 40,
                        // width: 100,
                        // decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     image: DecorationImage(
                        //         scale: 1.2,
                        //         image: AssetImage(
                        //           data.imageAsset ?? '',
                        //         ))

                        //         ),
                      )),
                  Flexible(
                      flex: 5,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              data.title ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            child: Text(
                              data.description ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        ],
                      )),
                  Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.topLeft,
                        child: Text(
                          data.time ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 13, color: Colors.grey),
                        ),
                      )),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => AddToDoDetails(
                                  isEdit: true,
                                  data: data,
                                )))),
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: const Icon(
                        Icons.edit,
                        size: 18,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                            title: "Delete The Task",
                            content:
                                "Are you sure to delete the task from list",
                            yesCallback: () {
                              controller?.deleteDocument(data, ctx);
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: const Icon(
                        Icons.delete,
                        size: 18,
                      ),
                    ),
                  )
                ],
              ),
              const Divider()
            ],
          )),
    );
  }
}
