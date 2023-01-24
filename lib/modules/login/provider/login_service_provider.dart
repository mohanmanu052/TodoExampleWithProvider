import 'package:eired_sample/modules/login/provider/login_service.dart';

class LoginServiceProvider {
  static ILoginService getApiService() {
    return LoginService();
  }
}
