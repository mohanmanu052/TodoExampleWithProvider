import 'package:eired_sample/modules/home/controller/home_controller.dart';
import 'package:eired_sample/modules/todo/model/todo_model.dart';
import 'package:eired_sample/modules/todo/widget/add_todo_deatils.dart';
import 'package:eired_sample/reusable/custom_alert.dart';
import 'package:eired_sample/reusable/custom_appbar.dart';
import 'package:eired_sample/reusable/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailTodoView extends StatelessWidget {
  TodoModel? data;
  DetailTodoView({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, controller, _) {
      return Scaffold(
        appBar: customAppBar(context, inputTitle: 'Details'),
        body: SafeArea(
            child: Container(
          margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              detailsList('Title :', data?.title ?? '', context),
              const SizedBox(
                height: 10,
              ),
              detailsList('Description :', data?.description ?? '', context),
              const SizedBox(
                height: 10,
              ),
              detailsList('Category :', data?.category ?? '', context),
              const SizedBox(
                height: 10,
              ),
              detailsList('Time :', data?.time ?? '', context),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableButton(
                    buttonText: 'Edit',
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => AddToDoDetails(
                                  isEdit: true,
                                  data: data,
                                )))),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ReusableButton(
                    onPressed: () async {
                      print('delete pressed--');
                      showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return CustomAlertDialog(
                            title: "Delete The Task",
                            content:
                                "Are you sure to delete the task from list",
                            yesCallback: () {
                              controller.deleteDocument(data!, context);
                            },
                          );
                        },
                      );
                    },
                    buttonText: 'Delete',
                  )
                ],
              )
            ],
          ),
        )),
      );
    });
  }

  Widget detailsList(String header, String body, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              header,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                body,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
