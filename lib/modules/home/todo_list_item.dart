import 'package:eired_sample/modules/todo/model/todo_model.dart';
import 'package:eired_sample/modules/viewtodo/widget/detail_todo_view.dart';
import 'package:flutter/material.dart';

class TodoListItem extends StatelessWidget {
  TodoModel? modeldata;
  TodoListItem({Key? key, this.modeldata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => DetailTodoView(
                    data: modeldata,
                  )))),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        modeldata?.imageAsset ?? ''))),
                          ))),

                  //   Im.asset(
                  //     'assets/googleicon.svg',
                  //     width: 40,
                  //     height: 40,
                  //   ),
                  // )),
                  Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              modeldata?.title ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            child: Text(
                              modeldata?.description ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        ],
                      )),
                  Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.centerRight,
                        child: Text(
                          modeldata?.time ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 13, color: Colors.grey),
                        ),
                      ))
                ],
              ),
              const Divider()
            ],
          )),
    );
  }
}
