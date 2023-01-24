import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceLocal {
  static final SharedPrefrenceLocal _singleton =
      SharedPrefrenceLocal._internal();

  factory SharedPrefrenceLocal() {
    return _singleton;
  }

  SharedPrefrenceLocal._internal();
  static Future<void> saveLogindata(String mobile, String email, String userId,
      {bool isMobileLogin = false, bool isLogged = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mobileNo', mobile);
    prefs.setString('email', email);
    prefs.setString('userId', userId);
    prefs.setBool('mobileLogged', isMobileLogin);
    prefs.setBool('isLogged', isLogged);
  }

  static Future<List<String>> getuserEmailorNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = '';
    email = prefs.getString('email');
    if (email!.isEmpty || email == null) {
      email = prefs.getString('mobileNo');
    } else {
      email;
    }
    String? userId = prefs.getString('userId');
    print('user is in shared prefrence was----1' + userId.toString());

    List<String> userIDNumber = [email!, userId!];

    return userIDNumber;
  }

  static Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userId = prefs.getString('userId');
    print('user is in shared prefrence was----' + userId.toString());
    return userId ?? '';
  }
}
