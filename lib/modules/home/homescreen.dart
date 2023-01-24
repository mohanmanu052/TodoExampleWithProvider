import 'package:eired_sample/constants/color_contants.dart';
import 'package:eired_sample/modules/home/controller/home_controller.dart';
import 'package:eired_sample/modules/home/nav_drawer.dart';
import 'package:eired_sample/modules/home/todo_list_item.dart';
import 'package:eired_sample/modules/todo/widget/add_todo_deatils.dart';
import 'package:eired_sample/reusable/fexible_app_bar.dart';
import 'package:eired_sample/reusable/nodata_found.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController? controller;
  @override
  void initState() {
    controller = Provider.of<HomeController>(context, listen: false);
    controller?.getUserMobilenumbername();
    // controller?.getTodoList();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, controller, _) {
      return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innnerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: ColorConstants.primaryColor,
                expandedHeight: 200.0,
                pinned: true,

                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  var top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    title: Text(
                      top > 71 && top < 120 ? "Your Things" : "",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    // background: Image.network(
                    //   "https://images.ctfassets.net/pjshm78m9jt4/383122_header/d79a41045d07d114941f7641c83eea6d/importedImage383122_header",
                    //   fit: BoxFit.cover,
                    // )
                    background: MyFlexiableAppBar(),
                  );
                }),

                // FlexibleSpaceBar(
                //   background: MyFlexiableAppBar(),

                // Container(
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage("assets/mountains.webp"),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),

                // title: Text('Your Things'),
              )
              // Container(),
              // SliverList(
              //   delegate: SliverChildBuilderDelegate(
              //     (_, int index) {
              //       return TodoListItem();
              //     },
              //     childCount: 20,
              //   ),
              // ),
              // ],
            ];
          },
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Inbox',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: controller.loadingState == DataState.LOADING
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.loadingState == DataState.EMPTY
                          ? NoDataFound(
                              onTrygainTap: () {
                                controller.getTodoList();
                              },
                            )
                          : controller.loadingState == DataState.UNKNOWN
                              ? const SizedBox()
                              : ListView.builder(
                                  padding: const EdgeInsets.all(4),
                                  shrinkWrap: true,
                                  itemCount: controller.todoData.length,
                                  itemBuilder: ((context, index) =>
                                      TodoListItem(
                                        modeldata: controller.todoData[index],
                                      ))),
                )
              ],
            ),
          ),
        ),
        drawer: NavDrawer(controller),
        floatingActionButton: FloatingActionButton(
          onPressed: (() => Navigator.push(context,
              MaterialPageRoute(builder: ((context) => AddToDoDetails())))),
          tooltip: 'New Task',
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
