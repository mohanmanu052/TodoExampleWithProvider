import 'package:eired_sample/constants/color_contants.dart';
import 'package:eired_sample/constants/shareprefrence_constants.dart';
import 'package:eired_sample/modules/home/controller/home_controller.dart';
import 'package:eired_sample/modules/login/widget/login_page.dart';
import 'package:eired_sample/modules/viewtodo/widget/todo_list.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  HomeController? homeController;
  NavDrawer(this.homeController);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConstants.primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Container(
            color: ColorConstants.primaryColor,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 40,
                  child: Image.asset('assets/person_icon.png'),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Welcome',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    homeController?.userEmailorNumber ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          )),
          listItem(Icons.input, 'View All Todo', () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => TodoListView())));
          }),
          listItem(Icons.feedback, 'Feedback', () => null),
          listItem(Icons.logout, 'LogOut', () {
            SharedPrefrenceLocal.clearData();

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false);
          }),
        ],
      ),
    );
  }

  Widget listItem(IconData icon, String titleText, Function() onTap) {
    return ListTile(
      textColor: Colors.white,
      iconColor: Colors.white,
      // tileColor: Colors.white,
      leading: Icon(icon),
      title: Text(titleText),
      onTap: onTap,
    );
  }
}
