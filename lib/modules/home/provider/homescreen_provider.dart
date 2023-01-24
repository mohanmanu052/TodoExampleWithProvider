import 'package:eired_sample/modules/home/provider/homescreen_service.dart';

class HomeScreenServiceProvider {
  static IHomeScreenService getHomeApiService() {
    return HomeScreenService();
  }
}
